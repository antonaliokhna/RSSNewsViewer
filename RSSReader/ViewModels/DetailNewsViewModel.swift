//
//  DetailNewsViewModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/4/23.
//

import Foundation
import UIKit

struct DetailNewsViewModel {
    let autor: String
    let title: String
    let description: String
    let pubDate: String
    let image: UIImage
    let caterogy: String
    let link: URL
}
//
//<item>
//  <guid>https://lenta.ru/news/2023/02/03/messi/</guid>
//  <author>Дарья Коршунова</author>
//  <title>Месси пожаловался на «убивавших» его на чемпионате мира-2022 журналистов</title>
//  <link>https://lenta.ru/news/2023/02/03/messi/</link>
//  <description>
//    <![CDATA[Капитан сборной Аргентины Лионель Месси рассказал о давлении со стороны журналистов во время чемпионата мира-2022 в Катаре. «Я думаю, люди видели все, с чем я боролся, пытаясь достичь этой цели, думаю, что то, с чем я столкнулся в сборной Аргентины, показалось многим людям несправедливым», — сказал он.]]>
//  </description>
//  <pubDate>Fri, 03 Feb 2023 14:24:00 +0300</pubDate>
//  <enclosure url="https://icdn.lenta.ru/images/2023/02/03/14/20230203140524680/pic_556d87ea4360ddd3edda9fa5f6f00452.jpeg" type="image/jpeg" length="25799"/>
//  <category>Спорт</category>
//</item>
