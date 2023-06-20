Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB70EB64D8
	for <linux-um@archiver.kernel.org>; Tue, 20 Jun 2023 23:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XLblpllfTIenp5Rzi4PHUjUF3UBWFazGsKFLjHPaCPY=; b=tvGV+WaSBI6VAF
	s6bKEXXiAx+kwChcyx8SmIRpaLlLU79BOG1z3Z3Sv1vI/vGo9u8pmajnAKYs+13XdmH81arjC2Is5
	P+tAAxso8x8Jy+N3nP9SrWdPQljdzzxQccfd7q4gc5wKg44CiOV5VXv16za5zb+h8gqXBnLn32gbU
	NIy2vPnWBd0269LgWRDyyJct8WNJzefsmMy5tJH0/7VhUfu9IfFWQbJHtILN8+/kqDzhPpCcdSTeu
	6gP1r8QuGZ/7Vnq24wDngvUFxU2c5moDaKO6w1bMErtd8OGY15gi4vd22FiiMHnauIn6le/rfijnb
	MahLRBI2BurOAMUV4vlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBkPb-00CXf6-2S;
	Tue, 20 Jun 2023 23:05:23 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBkPZ-00CXdH-0S;
	Tue, 20 Jun 2023 23:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAsqsJZKEBx38D1P5a7N1Jr3Rbd4OczRiaO89yYo9WPjer3aJHQG/2F2lA5FjQKCisiK4oPu8LHQuEnEVill/d8/Yo1NsGh3+YisL+t55VevPgvMiW933XI46Wp32QWAVUKk/ZHTQQVdb+ltWYn7ypHG2qfeJaD9djIUUqP0QY0QkJXf8t7GyawAJGdGqSBTHHz1ASQ0dg4XjUcmuwFCDBN6Uro8+k9f5bJ8TbZHZNutcWMUDSta1wffvwH6yPeRw+yOpY74HVjbZSKm9k+LI7OHRLw1hnvARfRhvLQ9NorPel8k3uXbHTtXwy7xY3rT4mR3NDunydAczqZdP1LYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltTIiBtZe5keN/2eRCeT5n726rQ4ogdJ3lncN2+uErk=;
 b=fcShjhjxkC7z2voYps6ZEdhCmACMsHBTr7lVigip++2wFKMK4WRmTBsEuPswBqiBpHGnXkIo4dv5ZN+1ZViXzqmrt+s40TWOmWp5kpBt5nQf2ake9dgABmCWWslWK34Yu1arNIaL/elBy9l22iyeT2We8aAeR9/xQuYiOc5xPz9uhoo6icyFy/nhl+v55xB5Ic8e2eChQu+Nzeo/SJlw1BhrX5r5gussacUU1Xo/gWFyj74ntecvf5sPdszA+Y+1Gz0xlJigLO6oqwR3NavBMForHMKXB+rP46h42KCk76sz5bTs2JCxN1vfqq8/11uFUyssSlV7cbqcosPz3ucBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltTIiBtZe5keN/2eRCeT5n726rQ4ogdJ3lncN2+uErk=;
 b=QlGuaa3Qx7T1/sBNlW/z3ccnCwjn/R1SShPsOeCqw4kB5ojYj5pPLBiAkHc0PKwg209K+9Fxl6ilpmMV18URVAeC5u9+Os/y1rDR2dcxrej0URZf0CtriqhjJI7vGFWn0vFCjCBS1k3a/16ldDjXUJvcQ2x3EzFgz/MSiU0DiEmwGq2FemrFz74ERGE0l3qZNL6eyQPSU2eTCraX7zcfbwGCkCJUAqt0CLVrEko/134SAirS55HhAEoeREwIN/pe3w/PA0sGx26Y4OvpPUjZxfBoQojIo1hQ5ZgiQ5aZnrQftdnMcwnBU1hl0vibL0jSfKtZ3JjEwzP4yejLH5os6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 23:05:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 23:05:10 +0000
Date: Tue, 20 Jun 2023 20:05:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
Message-ID: <ZJIwpO68kc3zMB/c@nvidia.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com>
 <ZIxXw9ERkYv+ipdd@nvidia.com>
 <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAOzc2pwMW64O0m4Zu4zVFTY+qCJRK7V+7niN_t1m7pLaJrtb2A@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: af9c6ca0-8ecf-460c-f580-08db71e2cc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oo9DFPA5oeloN7xGzm07ngwHI/ma6YfGkq+TcV/QsCbfwAqOIODlMtDRpQMrh9zEQGtQ+2oQjjkwlnQQXb62Omc/6I0UdBVTBTu4yVDlxRDExk5c7ph1JGMXJ6FivilmsF3weqmwT35SXe88V+T9l3YeJOLlj1iD4jz9FKaWiw81SokUYq8CyJc3EcFLZWJ+817+fFWNAZKDZbMeB0MbbPN01Fa2jQdMcozgtJnFDAzGODsS/4Xq5NvRmbmDEeqL0prbZBATb+eHL1tq6OyrHKD5mjkzk/PLCnudynSetLxSv7fh42hsTTAn8xRomjD3I+IHbBg40gYrkVwiLBNxIATmy1rOtcKuM7IYdc3g7Dsj8/1S8SMpEpz/KzRGvcJxLN9NlSwhtRNMb2iz5Bnm5culwdwSeNnQMIZEaYi/WIbdbl6bvJTbKs0aM+6IxYPhMrHAKKJSe2N1U8PawFmLWg8TeXGDZWqZ880mbBnQyC+kSHnKZqjicg5mgZMLA9JHln0s/h7EsX7oOtKe8QzimYF4prgC4F2eLGnsvche018B1Q5yuJ9cUdiAkZkUFxA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(6486002)(478600001)(83380400001)(186003)(6512007)(6506007)(53546011)(2616005)(36756003)(26005)(86362001)(38100700002)(8676002)(5660300002)(8936002)(316002)(2906002)(41300700001)(4326008)(6916009)(66476007)(66556008)(66946007)(7416002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azBzSlhoQzNXeWJjSzROZjl0OWxseUdGajZVK3Y5RjZWWUE1b1dLRjNzeThw?=
 =?utf-8?B?MG1pZ3Q1NDFLU0RNVnFCeDdHWEdkUVl6UVZqVUIrUmpXY0E3SndpQ2tPNHBC?=
 =?utf-8?B?NUhzdDRua2dUd3FMVGsybEx1eUs1TmMrY1o0MFUwcVptQ0xRTEdTdmRMRm01?=
 =?utf-8?B?K1IxRXdwQmxUTno0QlMvejF4MGRWM2xHdGhSN3U3WDZrQXFpdEY5Rk5TQWpy?=
 =?utf-8?B?aHZTSHNrdnlJRVczWXZ3a0F5TGFrSGV3L1o0ZURpRDlnSXdJWDhUMTk5YlRa?=
 =?utf-8?B?WjNRa3U1eWlWSU1lNmpRSDEvYmVOTU1kdXFCQ0t0cDk4am9SemxEMU0xTllm?=
 =?utf-8?B?RUxnVzRJellGRXFoSFVlQzJPR0xVSEdCc3UrRmZvL2RwUWVwd2xhNlhxTFg3?=
 =?utf-8?B?R0ZNRFV5bjBhbXRldXFXUks4Q1JYQUJuQms1WHBFT29sOFkwbUVtbktNbkpU?=
 =?utf-8?B?cEVRU2xBaHlHSnExcEd3VWNQNmZRU2diSEs4OGRJaFJhdmw5dVh3ZlRCRlJD?=
 =?utf-8?B?eXNtZDdOQzJOTXdrZHJWeVNGWkJPVStNU0x0NGFMTDVGZlJ4QUhWaXVsSjMr?=
 =?utf-8?B?dFZIMVNrMEtYOSthOEl3QTZsVEE4U0lTdVI4T0FhNXVFbjc5MXZaQ3p2WTg1?=
 =?utf-8?B?UG5EcWdIRHIxWDdXOVBTQkdoUVhuaEluZnRMVDJmOHZ6a1lrbFAxYWkyN0k4?=
 =?utf-8?B?V1VCSVRIV29rVTBISjdrSnY2WmNRZ2x2Y2N6cHpBdlo3SWJxbVZpd2pEVXl6?=
 =?utf-8?B?U2ZtTWFkU3RGSU1MUTBMU3FWeEVJbVVuLzhFLzBzZ3NxZzBITXFhNDUvdGNY?=
 =?utf-8?B?OUg3RkMvL2xQSEt2Z1lIcVVVd0F1UnFaNmFtdVplR2dEdTFiS3lWbVdMQU13?=
 =?utf-8?B?eDFCaHhhNFkvajVRUGp1MnRYY0JYVDVyc1VabVBwWmVld3R6UWQ3bXpIRUU2?=
 =?utf-8?B?Ti9qQ005c3Q4YWVhZnRhZ2F6S1ZZK0hYUDcvUkltRlFPcVZNanVXZDdFTHcr?=
 =?utf-8?B?aFA0ZGczT2wvbUJFUW1QRFhjWnhkeVlEN3dwVWVsUG91eHVRZ1dEenN4WEdi?=
 =?utf-8?B?VHhhMmJMbXJCelMzMkN5TTM2ZTRaU21aWUE3YzFRR2gwa21ocUpManlKc1JJ?=
 =?utf-8?B?RzVZc1Fpb3QwN3lWMCs3c2d6cll3ODM1RFBLWmZ1Q1dXckhnc3FFdCtVVWhu?=
 =?utf-8?B?THZlM0xHYzU1KzNOZ2pBNlpjd0JudmZYV2RXYkY0R2RvN0lYTUczL2hyaWtR?=
 =?utf-8?B?UElsQWFoMTJEbHZ1aVJFQmdKNW45cW9VcklKME5XMEVCWHJoZWhGSURXU0ND?=
 =?utf-8?B?Qy95OXlabjhMSW4zSi9WbXFjWkRSWlJ2ZjVxT05GQkhlOW9IV0ZZNHppM3Z5?=
 =?utf-8?B?MDJ6WlovU3BxcnFwZU03TXNKNHcrVzErQTNKZFY4UnB2c2UzWE80bWJxZDMr?=
 =?utf-8?B?V21Ocjd4YTVrbDJQeTh4a2hDdzA3cVdQMWRFamF4TUsrLy95M3dQSDZmVlBa?=
 =?utf-8?B?VEo2RHhwaWZreDRBdkJ6Ryt3WExIbzZXOTB6MHhLcXMweFY5UkwxcGdQcGt5?=
 =?utf-8?B?SzRVUUF4eDdrcUVvRWNNVjZsRllEK3dqaUlTL0lNRW5hd2pHcFRCUHdITGJG?=
 =?utf-8?B?WEkvSHVXdEpjNVYyMHo3WVhCbWloUlJCRjUrdllmeExOTkJNSGpTaWc4RE1S?=
 =?utf-8?B?RGZ1aGlCY1I3RlZhT1JpNFlNM0x5bU0rMHNZa0pzS3NBZThSQUs4bW80cFc4?=
 =?utf-8?B?VzFkaXNmS2VGaVhaTFV4WWZqcWk5RHhoV0JEcFJ4MUdnQTZLQ2I0T29vWkhZ?=
 =?utf-8?B?Ym9GdFdQZFZpanJpSlA5c21Ra1lBVnl6SXRRdFgvQk94NENwaERTcWo5aDJZ?=
 =?utf-8?B?cUhMVmFJUkZmRUpWNUdFWHUxaXhobXRMbHVWbVFLL2pQazRuaXRvcUM4Nmlm?=
 =?utf-8?B?N2ZCTE9OSjBhbjJmb24zT09qQzNjTzFVM05xbU42S3NLWlJxTmorU1BHSXh6?=
 =?utf-8?B?SnNJY2Q0WjVucEQ5bTZlTGw4WERsdHlXZEJkRGwvbEx5K0VEeG0xdUJCcXBS?=
 =?utf-8?B?WFgxSTRneE4xWlhQc0hwbmpuMktPclkzYkViYm0zQVU2VXQxZk43VUI1c28r?=
 =?utf-8?Q?9vgoPf+W0tynJua4GrNJ45e8y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9c6ca0-8ecf-460c-f580-08db71e2cc0f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 23:05:10.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+LKfZovjZy61f+HGv7RJ64nxAoBBBqUKUgPMSNcpJkcIbEmsgeezoq6nuoAuxkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_160521_205093_2BCDBE5A 
X-CRM114-Status: GOOD (  22.56  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKdW4gMjAsIDIwMjMgYXQgMDE6MDE6MzlQTSAtMDcwMCwgVmlzaGFsIE1vb2xhIHdy
b3RlOgo+IE9uIEZyaSwgSnVuIDE2LCAyMDIzIGF0IDU6MzjigK9BTSBKYXNvbiBHdW50aG9ycGUg
PGpnZ0BudmlkaWEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEp1biAxMiwgMjAyMyBhdCAw
MjowMzo1M1BNIC0wNzAwLCBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgd3JvdGU6Cj4gPiA+IEN1cnJl
bnRseSwgcGFnZSB0YWJsZSBpbmZvcm1hdGlvbiBpcyBzdG9yZWQgd2l0aGluIHN0cnVjdCBwYWdl
LiBBcyBwYXJ0Cj4gPiA+IG9mIHNpbXBsaWZ5aW5nIHN0cnVjdCBwYWdlLCBjcmVhdGUgc3RydWN0
IHB0ZGVzYyBmb3IgcGFnZSB0YWJsZQo+ID4gPiBpbmZvcm1hdGlvbi4KPiA+ID4KPiA+ID4gU2ln
bmVkLW9mZi1ieTogVmlzaGFsIE1vb2xhIChPcmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29t
Pgo+ID4gPiAtLS0KPiA+ID4gIGluY2x1ZGUvbGludXgvcGd0YWJsZS5oIHwgNTEgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1
MSBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Bn
dGFibGUuaCBiL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oCj4gPiA+IGluZGV4IGM1YTUxNDgxYmJi
OS4uMzMwZGU5NmViZmQ2IDEwMDY0NAo+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BndGFibGUu
aAo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3BndGFibGUuaAo+ID4gPiBAQCAtOTc1LDYgKzk3
NSw1NyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcHRlcF9tb2RpZnlfcHJvdF9jb21taXQoc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWEsCj4gPiA+ICAjZW5kaWYgLyogX19IQVZFX0FSQ0hfUFRFUF9N
T0RJRllfUFJPVF9UUkFOU0FDVElPTiAqLwo+ID4gPiAgI2VuZGlmIC8qIENPTkZJR19NTVUgKi8K
PiA+ID4KPiA+ID4gKwo+ID4gPiArLyoqCj4gPiA+ICsgKiBzdHJ1Y3QgcHRkZXNjIC0gTWVtb3J5
IGRlc2NyaXB0b3IgZm9yIHBhZ2UgdGFibGVzLgo+ID4gPiArICogQF9fcGFnZV9mbGFnczogU2Ft
ZSBhcyBwYWdlIGZsYWdzLiBVbnVzZWQgZm9yIHBhZ2UgdGFibGVzLgo+ID4gPiArICogQHB0X2xp
c3Q6IExpc3Qgb2YgdXNlZCBwYWdlIHRhYmxlcy4gVXNlZCBmb3IgczM5MCBhbmQgeDg2Lgo+ID4g
PiArICogQF9wdF9wYWRfMTogUGFkZGluZyB0aGF0IGFsaWFzZXMgd2l0aCBwYWdlJ3MgY29tcG91
bmQgaGVhZC4KPiA+ID4gKyAqIEBwbWRfaHVnZV9wdGU6IFByb3RlY3RlZCBieSBwdGRlc2MtPnB0
bCwgdXNlZCBmb3IgVEhQcy4KPiA+ID4gKyAqIEBfcHRfczM5MF9nYWRkcjogQWxpYXNlcyB3aXRo
IHBhZ2UncyBtYXBwaW5nLiBVc2VkIGZvciBzMzkwIGdtYXAgb25seS4KPiA+ID4gKyAqIEBwdF9t
bTogVXNlZCBmb3IgeDg2IHBnZHMuCj4gPiA+ICsgKiBAcHRfZnJhZ19yZWZjb3VudDogRm9yIGZy
YWdtZW50ZWQgcGFnZSB0YWJsZSB0cmFja2luZy4gUG93ZXJwYyBhbmQgczM5MCBvbmx5Lgo+ID4g
PiArICogQHB0bDogTG9jayBmb3IgdGhlIHBhZ2UgdGFibGUuCj4gPiA+ICsgKgo+ID4gPiArICog
VGhpcyBzdHJ1Y3Qgb3ZlcmxheXMgc3RydWN0IHBhZ2UgZm9yIG5vdy4gRG8gbm90IG1vZGlmeSB3
aXRob3V0IGEgZ29vZAo+ID4gPiArICogdW5kZXJzdGFuZGluZyBvZiB0aGUgaXNzdWVzLgo+ID4g
PiArICovCj4gPiA+ICtzdHJ1Y3QgcHRkZXNjIHsKPiA+ID4gKyAgICAgdW5zaWduZWQgbG9uZyBf
X3BhZ2VfZmxhZ3M7Cj4gPiA+ICsKPiA+ID4gKyAgICAgdW5pb24gewo+ID4gPiArICAgICAgICAg
ICAgIHN0cnVjdCBsaXN0X2hlYWQgcHRfbGlzdDsKPiA+ID4gKyAgICAgICAgICAgICBzdHJ1Y3Qg
ewo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBfcHRfcGFkXzE7Cj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICBwZ3RhYmxlX3QgcG1kX2h1Z2VfcHRlOwo+ID4gPiAr
ICAgICAgICAgICAgIH07Cj4gPiA+ICsgICAgIH07Cj4gPiA+ICsgICAgIHVuc2lnbmVkIGxvbmcg
X3B0X3MzOTBfZ2FkZHI7Cj4gPiA+ICsKPiA+ID4gKyAgICAgdW5pb24gewo+ID4gPiArICAgICAg
ICAgICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKnB0X21tOwo+ID4gPiArICAgICAgICAgICAgIGF0b21p
Y190IHB0X2ZyYWdfcmVmY291bnQ7Cj4gPiA+ICsgICAgIH07Cj4gPiA+ICsKPiA+ID4gKyNpZiBB
TExPQ19TUExJVF9QVExPQ0tTCj4gPiA+ICsgICAgIHNwaW5sb2NrX3QgKnB0bDsKPiA+ID4gKyNl
bHNlCj4gPiA+ICsgICAgIHNwaW5sb2NrX3QgcHRsOwo+ID4gPiArI2VuZGlmCj4gPiA+ICt9Owo+
ID4KPiA+IEkgdGhpbmsgeW91IHNob3VsZCBpbmNsdWRlIHRoZSBtZW1jZyBoZXJlIHRvbz8gSXQg
bmVlZHMgdG8gYmUgdmFsaWQKPiA+IGZvciBhIHB0ZGVzYywgZXZlbiBpZiB3ZSBkb24ndCBjdXJy
ZW50bHkgZGVyZWYgaXQgdGhyb3VnaCB0aGUgcHRkZXNjCj4gPiB0eXBlLgo+IAo+IFllcywgdGhh
bmtzIGZvciBjYXRjaGluZyB0aGF0ISBJJ2xsIGFkZCBpdCB0byB2NS4KPiAKPiA+IEFsc28sIGRv
IHlvdSBzZWUgYSB3YXkgdG8gc29tZWRheSBwdXQgYSAnc3RydWN0IHJjdV9oZWFkJyBpbnRvIGhl
cmU/Cj4gCj4gRXZlbnR1YWxseSwgd2hlbiB0aGV5J3JlIGJlaW5nIGR5bmFtaWNhbGx5IGFsbG9j
YXRlZCBpbmRlcGVuZGVudCBvZgo+IHN0cnVjdCBwYWdlLiBBbHRob3VnaCBhdCB0aGF0IHBvaW50
IEknbSBub3Qgc3VyZSBpZiB3ZSdsbCBuZWVkIG9uZS4KClNvb25lciB0aGFuIGR5bmFtaWMgc3Ry
dWN0IHBhZ2U/CgpQcm9iYWJseSBpdCBjYW4gb3ZlcmxhcCBwdF9saXN0IGluIGFsb3Qgb2YgYXJj
aGVzPwoKSmFzb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
