# Define variables

BROWSER = "Chrome"
URL = "https://gabi-spa.vercel.app/"
USERNAME = "minhtrung"
PASSWORD = "123123Aa."

# set variables Xpath login

XPATH_LOGIN = "//div[contains(@class, 'hidden lg:flex')]/button[text()='Đăng nhập']"
XPATH_SUBMIT = "//button[@class='bg-[#214581] text-white w-32 rounded-md px-2 py-1']"
# set variables Xpath Servie

XPATH_SERVICE = "//a[contains(text(),'Dịch vụ')]"
XPATH_SERVICE_DETAILS = "(//a[contains(text(),'Xem Chi Tiết')])[1]"
XPATH_SERVICE_BOOKED = "//button[contains(text(),'Đặt Lịch Ngay')]"
XPATH_SERVICE_BOOKED_SUBMIT = "//button[contains(@class,'border-2 border-transparent')][contains(text(),'Xác Nhận')]"
XPATH_INPUT_START_SERVICE = "//input[contains(@type,'datetime-local')]"

# set variables Xpath Servie status

Invalid_service_start_date_xpath = "//div[text()='Ngày bắt đầu dịch vụ không hợp lệ']"
Service_start_date_not_available_xpath = "//div[text()='Vui lòng chọn ngày bắt đầu dịch vụ']"
