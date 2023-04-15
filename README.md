# Unsplash_Clone

> Unsplash 앱의 클론코딩 프로젝트 입니다. 

## 구조 분석 

- 총 4개의 탭으로 구성 되어있습니다. 

|Home|Search|Submit|MyPage|
|:---:|:---:|:---:|:---:|
|<img src="https://i.imgur.com/Od6p1nF.jpg" width="130">|<img src="https://i.imgur.com/x2K1pHs.jpg" width="130">|<img src="https://i.imgur.com/2SBSiw0.jpg" width="130">|<img src="https://i.imgur.com/DYuvl4c.png" width="130">|

- Home : 컬렉션뷰, 횡스크롤 카테고리 탭
- Search : 컴포지셔널 레이아웃, 서치바
- Submit : 컴포지셔널 레이아웃, 
- MyPage : 세그먼트 컨트롤, 액티비티 컨트롤러, 드롭다운 메뉴

앱 전체적인 UI 를 보았을 때 SwiftUI 로 그렸다고 생각되었습니다. 하지만 UIKit으로 진행 후, 부분적으로 SwiftUI를 적용해볼 예정입니다. 

## 라이브러리 분석

> 라이브러리를 직접 만들어보는 [과정](https://hackmd.io/Cgetb0viSM-XVqJnAmp7bw)을 경험하니, 이제 어떤식으로 제작자의 의도를 빠르게 파악할 수 하는지 알게 되었습니다. 

- unsplash 에서 제공하는 [API](https://github.com/unsplash/unsplash-photopicker-ios) 를 분석합니다. 
- Example 앱을 실행해보니 Secret Key가 없어 서버에러가 났습니다. 
- [unsplash 개발자문서 - 앱등록](https://unsplash.com/documentation#registering-your-application) 에서부터 시작 해야겠습니다. 
- 앱 등록 후 Access Key 와 Secret Key를 코드상 등록해주니 Example 앱이 잘 작동합니다. 

```swift
@IBAction func presentUnsplashPhotoPicker(sender: AnyObject?) {
        let allowsMultipleSelection = selectionTypeSegmentedControl.selectedSegmentIndex == SelectionType.multiple.rawValue
        let configuration = UnsplashPhotoPickerConfiguration(
            accessKey: "accessKey주입",
            secretKey: "secretKey주입",
            query: searchQueryTextField.text,
            allowsMultipleSelection: allowsMultipleSelection
        )
        let unsplashPhotoPicker = UnsplashPhotoPicker(configuration: configuration)
        unsplashPhotoPicker.photoPickerDelegate = self

        present(unsplashPhotoPicker, animated: true, completion: nil)
    }

```

- 라이브러리에 구현되어있는 `UnaplshPhotoPicker`객체를 이용해 검색결과 화면을 볼 수 있습니다. 
- `WaterfallLayout` 이라는 커스텀 레이아웃을 이용해서 `CollectionView`를 표현한 것이 흥미로웠습니다. 
- 스크롤 시, 이미지를 `decode` 하는 동안 `UnsplashPhoto` 객체가 가지는 `color` 프로퍼티로 미리 배경색이 정해지는데, 이미지를 다운받는 동안에 이 컬러로 표시되는 것이 로딩을 기다리는 눈의 불편함을 줄여주었습니다.
<img src="https://i.imgur.com/nJ8aavk.jpg" width="200">

## UI 개발 
> SwiftUI로 개발하며 Preview의 편리함을 잊을 수 없어서 UIKit 에서도 적용해주려고 합니다.
- UIKit
- Preview

## References
- [Unsplash-Developer](https://unsplash.com/developers)
- [김종권님의 블로그 - Preview 적용](https://ios-development.tistory.com/488)
