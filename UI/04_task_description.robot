*** Settings ***
Documentation    Suite description
Resource          resource.robot
Suite Setup       Open Browser     http://localhost:3000/tasks/create   chrome
Suite Teardown    Close Browser

*** Test Cases ***
More Than 1000 Symbols In Description
    Tasks Registration Keyword    ${task_name}  Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui  ${start_date}  ${end_date}  ${label}
    sleep   1
    ${alert}=       Get WebElement      class:alert
    Element Text Should Not Be     ${alert}     Task has been created

Empty Description
    Tasks Registration Keyword    ${task_name}  ${empty}  ${start_date}  ${end_date}  ${label}
    sleep   1
    Alert Should Be Present   Please fill all form data

Space Description
    Tasks Registration Keyword    ${task_name}  ${space}  ${start_date}  ${end_date}  ${label}
    sleep   1
    Alert Should Be Present   Please fill all form data
