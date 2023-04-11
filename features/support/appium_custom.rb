# frozen_string_literal: true

def validarTexto(elemento)
  esperaElemento(elemento)
  case elemento['tipo_busca']
  when 'XPATH'
    $driver.find_element(:xpath, elemento['value']).text
  when 'TEXT'
    $driver.find_element(:xpath, "//*[contains(@text,'#{elemento['value']}')]").text
  when 'ACCESSIBILITY'
    $driver.find_element(:accessibility_id, elemento['value']).text
  end
end

def clicar(el)
  esperaElemento(el)
    case el['tipo_busca']
    when 'XPATH'
        $driver.find_element(:xpath, el['value']).click
    when 'ID'
        $driver.find_element(:id, el['value']).click
    when 'CLASS'
        $driver.find_element(:class, el['value']).click
    when 'TEXT'
        $driver.find_element(:xpath, "//*[contains(@text,'#{el['value']}')]").click
    end
    $logger.info('Clicou no botão ' + el['value'] + ' usando o tipo de busca' + el['tipo_busca'])
end

def escreverTexto(el, text)
    case el['tipo_busca']
    when 'XPATH'
      element = $driver.find_element(:xpath, el['value'])
    when 'ID'
      element = $driver.find_element(:id, el['value'])
    when 'CLASS'
      element = $driver.find_element(:class, el['value'])
    when 'TEXT'
        element = $driver.find_element(:xpath, "//*[contains(@text,'#{el['value']}')]")
    end
    element.clear
    element.send_keys text
    $logger.info("Preencheu o campo #{el} usando o tipo de busca #{el['tipo_busca']} com o valor #{text}")
end

def esperaElemento(el)
  puts "Aguardando o elemento: #{el['value']} com o tipo de busca: #{el['tipo_busca']}"
  case el['tipo_busca']
  when 'XPATH'
    $wait.until {elementoExistente? el}
  when 'ID'
    $wait.until {elementoExistente? el}
  when 'CLASS'
    $wait.until {elementoExistente? el}
  when 'TEXT'
    $wait.until {elementoExistente? el}
  when 'ACCESSIBILITY'
    $wait.until { elementoExistente?(el) }
  end
  $logger.info("Aguardou a existência do elemento #{el['value']} usando o tipo de busca #{el['tipo_busca']}")
end


def elementoExistente?(el)
  $logger.info("Verificando se existe o elemento #{el['value']} usando o tipo de busca #{el['tipo_busca']}")
  case el['tipo_busca']
  when 'XPATH'
    return $driver.find_elements(:xpath, el['value']).count > 0
  when 'ID'
    return $driver.find_elements(:id, el['value']).count > 0
  when 'CLASS'
    return $driver.find_elements(:class, el['value']).count > 0
  when 'TEXT'
    return $driver.find_elements(:xpath, "//*[contains(@text,'#{el['value']}')]").count > 0
  when 'ACCESSIBILITY'
    return $driver.find_elements(:accessibility_id, el['value']).count > 0
  end
end

def android?
    $platform == 'android'
end

def ios?
    $platform == 'ios'
end

## MÉTODO COMPLEMENTARES 

def wait_for(el)
  case el['tipo_busca']
  when 'XPATH'
    $wait.until { $driver.find_element(:xpath, el['value']).displayed? }
  when 'ID'
    $wait.until { $driver.find_element(:id, el['value']).displayed? }
  when 'CLASS'
    $wait.until { $driver.find_element(:class, el['value']).displayed? }
  end
  $logger.info("Aguardou a exibição do elemento #{el['value']} usando o tipo de busca #{el['tipo_busca']}")
end

def hide_keyboard
  if android?
    $driver.hide_keyboard
  elsif ios?
    $driver.hide_keyboard :pressKey
  end
  $logger.info('Fechou o teclado virtual')
end