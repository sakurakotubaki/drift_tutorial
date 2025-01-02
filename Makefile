.PHONY: setup
setup:
	@flutter clean
	@flutter pub get

.PHONY: watch
watch:
	@flutter pub run build_runner watch --delete-conflicting-outputs

.PHONY: build
build:
	@flutter pub run build_runner build --delete-conflicting-outputs

.PHONY: clean
clean:
	@flutter clean
	@flutter pub get
	@flutter pub run build_runner clean

.PHONY: gen
gen:
	@flutter pub run build_runner build
	@flutter pub get
	@flutter gen-l10n

.PHONY: run
run:
	@flutter run

.PHONY: test
test:
	@flutter test

.PHONY: format
format:
	@dart format lib/
	@dart fix --apply