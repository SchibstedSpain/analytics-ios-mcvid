XCPRETTY := xcpretty -c && exit ${PIPESTATUS[0]}

SDK ?= "iphonesimulator"
DESTINATION ?= "platform=iOS Simulator,name=iPhone 7"
PROJECT := analytics-ios-mcvid
XC_ARGS := -scheme $(PROJECT)-Example -workspace Example/$(PROJECT).xcworkspace -sdk $(SDK) -destination $(DESTINATION) ONLY_ACTIVE_ARCH=NO

install: Example/Podfile analytics-ios-mcvid.podspec
	pod repo update
	pod install --project-directory=Example

clean:
	xcodebuild $(XC_ARGS) clean | $(XCPRETTY)

build:
	xcodebuild $(XC_ARGS) | $(XCPRETTY)

test:
	xcodebuild test $(XC_ARGS) | $(XCPRETTY)

xcbuild:
	xctool $(XC_ARGS)

xctest:
	xctool test $(XC_ARGS)

.PHONY: test build xctest xcbuild clean
.SILENT:
