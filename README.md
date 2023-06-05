# Unsplash_Clone

> Unsplash 앱의 클론코딩 프로젝트 입니다. 
xx

## 구조 분석 

- 총 4개의 탭으로 구성 되어있습니다. 

|Home|Search|Submit|MyPage|
|:---:|:---:|:---:|:---:|
|<img src="https://i.imgur.com/Od6p1nF.jpg" width="130">|<img src="https://i.imgur.com/x2K1pHs.jpg" width="130">|<img src="https://i.imgur.com/2SBSiw0.jpg" width="130">|<img src="https://i.imgur.com/DYuvl4c.png" width="130">|

- Home : 테이블뷰, 횡스크롤 카테고리 탭
- Search : 컴포지셔널 레이아웃, 서치바
- Submit : 컴포지셔널 레이아웃, 
- MyPage : 세그먼트 컨트롤, 액티비티 컨트롤러, 드롭다운 메뉴

앱 전체적인 UI 를 보았을 때 SwiftUI 로 그렸다고 생각되었습니다. 하지만 UIKit으로 진행 후, 부분적으로 SwiftUI를 적용해볼 예정입니다. 

## API문서 분석

> 라이브러리를 직접 만들어보는 [과정](https://hackmd.io/Cgetb0viSM-XVqJnAmp7bw)을 경험하니, 이제 제작자의 의도를 빠르게 파악할 수 있었습니다.

- unsplash 에서 제공하는 [API](https://github.com/unsplash/unsplash-photopicker-ios) 를 분석합니다. 
- [unsplash 개발자문서 - 앱등록](https://unsplash.com/documentation#registering-your-application) 에서부터 시작 합니다. 
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

## 🔑 핵심 기술
- UIKit
- SnapKit
- Preview
- MVVM
- RxSwift

## 🛠️ Trouble Shooting

### ⚙️ TableView dynamic cell height 지정 
- 목표
    - 여러개의 이미지 데이터를 같은 너비로 고정한 채로 테이블뷰 셀의 높이를 동적으로 적용해주려고 합니다.
- 문제점
    - 고해상도 이미지의 경우 셀이 5883 높이로 지정되는 이슈
    - 그냥 적용했을 때 이미지가 위 아래로 길게 늘어나는 이유는 이미지의 원본 높이값이 계산에 적용되었기 때문이고, 이는 이미지 해상도가 높을수록 더 길어질 것입니다. 
    - 실제로는 약 700~800 정도의 높이로 계산되어야 합니다.
- 문제점 분석
    - 동적 셀 높이를 적용해줄 때는 오토레이아웃이 셀의 높이를 파악할 수 있도록 제약설정을 명시적으로 해주어야 합니다. 
- 해결방법
    - 해법은 이미지 자체를 resize 해주는 것이었습니다. UIImage+Extension 에 resize 메서드를 만들어 이미지를 다시 그려주면 이미지의 높이를 원본높이 ex) 5884 가 아닌 resize된 높이 ex) 700~800 로 인식하여 셀의 동적높이를 계산해줍니다. 
    
### ⚙️ NavigationBar에 투명, 그라이언트 속성 주기
- 목표
    - 네비게이션 바를 투명하게 만들고, 어두운 gradient 속성을 적용해줍니다.
- 구현방법
    - `CAGradientLayer` 를 이용해 Gradient 속성을 정의한 후, view.layer.addSublayer() 를 통해 layer를 등록해주었습니다.

## References
- [Unsplash-Developer](https://unsplash.com/developers)
- [김종권님의 블로그 - Preview 적용](https://ios-development.tistory.com/488)
- [Namsu님의 medium - 이미지 resize, downsampling](https://nsios.tistory.com/154)
