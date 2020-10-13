# create either a functional [-f] or class [-c] component
# default path src/components
# option to select different path

# $ component [name] [type] [opt:path]

function component(){

    # get projects root dir
    homeDir=$(pwd)
   
    # check we have a component name and type (-c or -f)
    if [ -z ${1} ] || [ -z ${2} ]
    then
        echo "Missing Argument/s - component [name] [type]"
        return
    fi

    # if no path is passed default to components dir
    if [ -z ${3} ]
    then
        dirName='components'
    else
        dirName=${3}
    fi

    # check we have either a class or functional arg
    if [ ${2} = -c ]
    then
        setDir ${1} ${2} $dirName
        cd $homeDir
    elif [ ${2} = -f ]
    then
        setDir ${1} ${2} $dirName
        cd $homeDir
    else
        echo "Incorrect type parameter -c [class] or -f [functional]"
        return
    fi

}

function setDir(){
    cd src
    # make a dir if it does not exist
    if [ ! -d ${3} ]
    then
        mkdir ${3}
    fi

    cd ${3}

    #  check component does not already exist
    if [ ! -d ${1} ]
    then
        mkdir ${1}
        cd ${1}
        touch ${1}.jsx
        # add stylesheet (change .scss to css/less etc if not using scss)
        touch ${1}.scss
        # add base class to stylesheet
         echo ".${1} {}" > ${1}.scss
        if [ ${2} = -c ]
        then
            writeClassComponent ${1}
        else
            writeFunctionalComponent ${1}
        fi
        # open created jsx file (if not configured, comment out)
        code ${1}.jsx
    else
        echo ${1} already exists
        return
    fi
}


# if component name has a hypen, remove and convert class to PascalCase
# sign-up would become SignUp for example
function PascalCase(){
    echo -n ${1} | awk 'BEGIN{FS="";RS="-";ORS=""} {$0=toupper(substr($0,1,1)) substr($0,2)} 1' >> ${1}.jsx
}

# boilerplate class component and style import (scss)
function writeClassComponent(){
    echo -n "import React from 'react';\nimport './${1}.scss';\n\nclass " > ${1}.jsx
    PascalCase ${1}
    echo -n " extends React.Component {\n\tconstructor() {\n\t\tsuper();\n\t\tthis.state = {}\n\t}\n\n\trender() {\n\t\treturn (\n\t\t\t<div className='${1}'>\n\n\t\t\t</div>)\n\t}\n}\n\nexport default " >> ${1}.jsx
    PascalCase ${1}
    echo ";\n" >> ${1}.jsx
}

# boilerplate functional component and style import (scss)
function writeFunctionalComponent(){
    echo -n "import React from 'react';\nimport './${1}.scss';\n\nconst " > ${1}.jsx
    PascalCase ${1}
    echo -n " = (props) => {\\n\treturn (\n\t\t<div className='${1}'>\n\n\t\t</div>)\n}\n\nexport default " >> ${1}.jsx
    PascalCase ${1}
    echo ";\n" >> ${1}.jsx
}