Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F029EB64DC
	for <linux-um@archiver.kernel.org>; Mon,  3 Jul 2023 14:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:Subject:References:Cc:
	To:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7aIzrjR29LKSLK3sqKOnZ4twdMfKkREujkOzA6yfGjI=; b=GarN3LO51tHbx0
	sNMIKb+Igksl0Ssp3772wX2moRn1deiKzHpbGCpCHLN6/Lr5sDtxWqOKtws1t9Xh1SJm31kRj2EzI
	ZMr/9/2JNaV93WlsmnA0raC86CouzXUnVyCLuq7g1/7L+ciUVEaKl47ftBMWWgDOxVTE5SQN3H4lD
	5f2mmBcMlKUeibBoV8L6kMje9uTJ+LQEAfqAX11m7PmtBFO7yv3qpUcbywGuBsMZHsbWKv1BdVXQz
	giHeu3aVUugyggsFWFcTN6HQ2ygYxbVcYozj22voOQAnzGAv/0+CaW43DfTuswE7pwZUCyS3K+P+F
	dyRsnxOS1ltyLC4ahIsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGKC6-00AiYJ-0I;
	Mon, 03 Jul 2023 14:06:22 +0000
Received: from mout.web.de ([212.227.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGKC3-00AiXe-22
	for linux-um@lists.infradead.org;
	Mon, 03 Jul 2023 14:06:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688393160; x=1688997960; i=markus.elfring@web.de;
 bh=/9QrnOK9EeQTPcym841zp6n9uyG5R4d/Tq7Ep872Wlw=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=KZq/4/4geTvQhutS3FVYCKghfRwRo2d+L4IPb5PKWe6E0rElNlRF9X43M2wwbNKKx3VpRJJ
 XR8afP8gtMt8ts0w/1z+XjIoXd0OrRHgHBEsg/2KpJS3Q4BV4bO9ip6w90xlZ48RiolQffDhw
 Rbaz6jBhHtcnnxxjNaU8YXrKRNJcBuNQZVpW6F+gdgw4EPDKV7o4uOfAYgGShTnKscEsoA1+E
 MvgBbyj2WBuX8KyOkorvosfzmW43ElPWKRdIEc8F9/7mVUqnjJI9fnWSL/fDvrc1Trnk7O93E
 SeQSoEYHcBtspXZYLM8PNQQhMQ+MP8DQ+DrpA3IF+VMcrAc3F2ew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIyeG-1qZW053pyE-00KlSL; Mon, 03
 Jul 2023 16:05:59 +0200
Message-ID: <8854675f-99e7-314e-c986-8dc954ee4a27@web.de>
Date: Mon, 3 Jul 2023 16:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Minjie Du <duminjie@vivo.com>, linux-um@lists.infradead.org,
 kernel-janitors@vger.kernel.org,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, Stephen Rothwell
 <sfr@canb.auug.org.au>, 11162212@vivo.com
Cc: LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
References: <20230703131129.8588-1-duminjie@vivo.com>
Subject: Re: [PATCH v2] drivers: use free_netdev before return in
 vector_eth_configure()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230703131129.8588-1-duminjie@vivo.com>
X-Provags-ID: V03:K1:3ZGst5SFbrAZh7Jt+GTFscupxK1MN6Fk6hy4hQ3TnIrzz9AQ4uc
 9nupl4ELydWq4rHlaX4avhAMS3pInvxtsu6mYYosNk1oWvxGTzyj9DT0pVmF0o0atJgz3AR
 jVcHeECleKwmrPfAdq0+Jf7xP67bbWNX2fH8uC1VtFLU7Tto1nih5/gk8lUfrYPDr+UM492
 juY7hV17BMj404avZQnnQ==
UI-OutboundReport: notjunk:1;M01:P0:INxNxtZ1wRc=;fSXPZUMjh6Jhqzz8RG2whASI5NB
 o4b3P3tO1XO9cSIIRZFTPxapahtg3N7QXGigpLEHhCg3VXFRv6mCFWDAogRzA2IhVHjqLYhLH
 39hOnVqMxEQr3L8TA5EljIuUF3/YcxBKdzhYBAujYUA7M1L5WB5jML4QQJJFdhlqNK2AvUSVF
 dxkjHLJSSXkk1kKbF/PFSrTXjlTsbmOEbtHSngV0k/fgHRPp+f5bsG2cWVi50LhBYApa+O8BK
 PtOZC62jFY+JVs7V2+Fk81Gfngn7I9GZsYpck5Mv+7RzKTRYNwUT7Vj7J8DyW/IbdmZ/2ZZVF
 XHxV0kyo0ozQDzTRdNAMInGqq54qWeVrcOZ5FWhWVSDCa+4TYF+MC0vTp7x28z9uObruQyUlN
 IzWt23wjz39DfCb5i4DTfXUt5Vl7JUr6oMWoUeUy7k4rexEUro4Bh5cG9qOvmtikxCRzg06Ck
 AE5yLRZXdXJQ15lezBAJvtxG+nKQmQgQR3K5Ag+N+L2DMpm+tgHfjzp7/ZyCUUc20j20S4ONi
 ZKo+dAmfMvhbUkJWZqbhCO/kU5fq+f3OLYK8AiGq3mVdnWm9TsJenr90i7Nn9ALtGsYAT0kLH
 XtyMYjRMq5hbmM5GYhlgfXm3IbYuFn1plFVJ1Cx7m+NIIKAqZkvSwEL68iUC1hIU8GPUHYblB
 Rv6NlowcT3PPGvodI7iyPtWha7k9YZzBi5xA0v4Peu0EFnHkcy1FG1WoYVqiJVefQ5JW9xGy8
 /iZDKPpSzi7YeURLMfMruwENyDshwgqyb/KzmXSiicC68YwGBd7iv3C0Qpj/2fjFceHX+S08Q
 WjNwfSrYAbEqhDqKJQNmYwiGqxKYCvh/EuJkpN5/O9rqZHxiRyf9azCxCIvx7Ih049aMBJGQN
 3vD14BRKJSDhuaZXGucg+VwT38d65Ctt0T/WaeCGWww+IohRmCKlc+ZU3xURwEiHcopKispw7
 693YnQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_070619_975338_7AF68349 
X-CRM114-Status: UNSURE (   6.42  )
X-CRM114-Notice: Please train this message.
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

V291bGQgdGhlIGluZm9ybWF0aW9uIOKAnHVtOiB2ZWN0b3I6IOKApuKAnSBiZSBtb3JlIGFwcHJv
cHJpYXRlCmZvciB0aGUgc3Vic3lzdGVtIHNwZWNpZmljYXRpb24gaW4gdGhlIHBhdGNoIHN1Ympl
Y3Q/CgoKCj4gV2Ugd2lsbCByZXBsYWNlIHRoZSBvbGQgdmVyc2lvbiBvZgo+IHVuZG9fdXNlcl9p
bml0IGFuZCB1c2Ugb3V0X2ZyZWVfbmV0ZGV2CgpQbGVhc2UgY2hvb3NlIGEgYmV0dGVyIGltcGVy
YXRpdmUgY2hhbmdlIHN1Z2dlc3Rpb24uCgpTZWUgYWxzbzoKaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1l
bnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Q/aD12Ni40I245NAoKCkhvdyBk
byB5b3UgdGhpbmsgYWJvdXQgdG8gYWRkIHRoZSB0YWcg4oCcRml4ZXPigJ0/CgpSZWdhcmRzLApN
YXJrdXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
