# frozen_string_literal: true

def clicar(el)
  esperar_elemento(el)
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

def escrever_texto(el, text)
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

def esperar_elemento(el)
  case el['tipo_busca']
  when 'XPATH'
    $wait.until {elemento_existente? el}
  when 'ID'
    $wait.until {elemento_existente? el}
  when 'CLASS'
    $wait.until {elemento_existente? el}
  when 'TEXT'
    $wait.until {elemento_existente? el}
  when 'ACCESSIBILITY'
    $wait.until { elemento_existente?(el) }
  end
  $logger.info("Aguardou a existência do elemento #{el['value']} usando o tipo de busca #{el['tipo_busca']}")
end


def elemento_existente?(el)
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

def validar_texto(elemento)
  esperar_elemento(elemento)
  case elemento['tipo_busca']
  when 'XPATH'
    $driver.find_element(:xpath, elemento['value']).text
  when 'TEXT'
    $driver.find_element(:xpath, "//*[contains(@text,'#{elemento['value']}')]").text
  when 'ACCESSIBILITY'
    $driver.find_element(:accessibility_id, elemento['value']).text
  end
end

def button_exists?(elemento)
  begin
    case elemento['tipo_busca']
    when 'ACCESSIBILITY'
      $logger.info("Verificando a existência do botão #{elemento['value']} usando o tipo de busca ACCESSIBILITY")
      el = $driver.find_elements(:accessibility_id, elemento['value'])
    when 'ID'
      $logger.info("Verificando a existência do botão #{elemento['value']} usando o tipo de busca ID")
      el = $driver.find_elements(:id, elemento['value'])
    when 'XPATH'
      $logger.info("Verificando a existência do botão #{elemento['value']} usando o tipo de busca XPATH")
      el = $driver.find_elements(:xpath, elemento['value'])
    else
      raise "Tipo de busca não suportado: #{elemento['tipo_busca']}"
    end
    return el.count > 0
  rescue Selenium::WebDriver::Error::NoSuchElementError
    return false
  end
end

def esperar_pelo_elemento(el)
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

def esconder_teclado
  if android?
    $driver.hide_keyboard
  elsif ios?
    $driver.hide_keyboard :pressKey
  end
  $logger.info('Fechou o teclado virtual')
end

def android?
  $platform == 'android'
end

def ios?
  $platform == 'ios'
end