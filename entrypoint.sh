#!/usr/bin/env bash

if [ -z ${INPUT_USEPYTHON3+x} ]; then
    echo "Using Default Python"
else
    echo using python $INPUT_USEPYTHON3
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${INPUT_USEPYTHON3} 10
    python3 --version
fi

if [ -f "poetry.lock" ]; then
    echo ::group::support poetry
    poetry export --without-hashes -f requirements.txt --output requirements.txt
    ls req*.txt
    echo "::endgroup::"
fi


echo ::group::analyzer
rm -rf /github/workspace/.ort/analyzer  || true
rm -rf /github/workspace/.ort/reports  || true
/opt/ort/bin/ort --debug analyze -f JSON -i /github/workspace/ -o /github/workspace/.ort/analyzer/ -i /github/workspace/$INPUT_WORKDIR
exitCode=$?

echo "::endgroup::"

echo ::group::reports

/opt/ort/bin/ort \
    report -f Excel,SpdxDocument,PdfTemplate,NoticeTemplate \
    --ort-file=/github/workspace/.ort/analyzer/analyzer-result.json \
    -o /github/workspace/.ort/reports
/opt/ort/bin/ort \
    report -f NoticeTemplate \
    --ort-file=/github/workspace/.ort/analyzer/analyzer-result.json -O NoticeTemplate=template.id=summary\
    -o /github/workspace/.ort/reports
    
echo "::endgroup::"

exit $exitCode
