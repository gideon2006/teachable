from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager

"""Tests the positive and negative login credentials"""

class login:

    def setUpClass(cls):
        # instantiate WebDriver
        cls.driver = webdriver.Chrome(ChromeDriverManager().install())
        cls.driver.get("https://takehome.zeachable.com")
        cls.driver.implicitly_wait(15)
        cls.driver.find_element_by_class_name("navbar-link fedora-navbar-link").click()

    def test_positive_login(self):
        # Test correct credentials
        username = "takehome@test.com"
        passWord = "Teachable"
        try:
            driver = webdriver.Chrome(ChromeDriverManager().install())
            driver.get("https://takehome.zeachable.com")
            driver.implicitly_wait(15)
            driver.find_element_by_class_name("navbar-link fedora-navbar-link").click()
            # username
            loginBox = driver.find_element_by_id('user_email')
            loginBox.send_keys(username)
            # password
            passWordBox = driver.find_element_by_id('user_password')
            passWordBox.send_keys(passWord)
            # submit button
            submitButton = driver.find_elements_by_xpath('//*[@id="new_user"]/div[3]/input')
            submitButton.click()
            print('Login Successful...!!')
            self.logout()
        except:
            print('Login Failed. Please verify username and pwd')

    def test_negative_login(self):
        # Test incorrect credentials.
        username = "takehome111@test.com"
        passWord = "teachable"

        try:
            #username
            loginBox = self.driver.find_element_by_id('user_email')
            loginBox.send_keys(username)
            #password
            passWordBox = self.driver.find_element_by_id('user_password')
            passWordBox.send_keys(passWord)
            #submit button
            submitButton = self.driver.find_elements_by_xpath('//*[@id="new_user"]/div[3]/input')
            submitButton.click()
            expected_msg ='Invalid email or password.'
            actual_msg = self.driver.find_elements_by_class_name('alert alert-danger')
            error_msg = ('Expected message: {} and actual message {}'.format(expected_msg, actual_msg))
            self.assertIn(expected_msg, actual_msg, error_msg)
            self.logout()
        except:
            print('Incorrect login validate message is missing/incorrect')

    def test_empty_login(self):
        # Test incorrect credentials.
        username = ""
        passWord = ""

        try:
            #username
            loginBox = self.driver.find_element_by_id('user_email')
            loginBox.send_keys(username)
            #password
            passWordBox = self.driver.find_element_by_id('user_password')
            passWordBox.send_keys(passWord)
            #submit button
            submitButton = self.driver.find_elements_by_xpath('//*[@id="new_user"]/div[3]/input')
            submitButton.click()
            expected_msg ='Invalid email or password.'
            actual_msg = self.driver.find_elements_by_class_name('alert alert-danger')
            error_msg = ('Expected message: {} and actual message {}'.format(expected_msg, actual_msg))
            self.assertIn(expected_msg, actual_msg, error_msg)
            self.logout()
        except:
            print('Incorrect login validate message is missing/incorrect')

    def logout(self):
        #This function will logout the user from the portal
        try:
            logout = self.driver.find_elements_by_xpath('//*[@id="navbar"]/div/div/div/ul/li[3]/ul/li[6]/a')
            logout.click()
            print('Logout was successful...!!')
        except:
            print('Logout was unsuccessful...!!')
