Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g2C3m-0004Uo-Q3
 for linux-um@lists.infradead.org; Tue, 18 Sep 2018 09:12:44 +0000
Received: from tun5.smaug.kot-begemot.co.uk ([192.168.18.6]
 helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.84_2) (envelope-from <anton.ivanov@cambridgegreys.com>)
 id 1g2BNT-0003j4-JA
 for linux-um@lists.infradead.org; Tue, 18 Sep 2018 08:28:59 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
 by smaug.kot-begemot.co.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@cambridgegreys.com>) id 1g2BNT-0007wt-34
 for linux-um@lists.infradead.org; Tue, 18 Sep 2018 09:28:59 +0100
Subject: Re: [PATCH] samples: disable CONFIG_SAMPLES for UML
References: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com>
 <2024081.XhWFmWp6tJ@blindfold>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1372d545-1fde-9352-a7e3-f09bf7fa2202@cambridgegreys.com>
Date: Tue, 18 Sep 2018 09:28:49 +0100
MIME-Version: 1.0
In-Reply-To: <2024081.XhWFmWp6tJ@blindfold>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org



On 09/18/18 09:21, Richard Weinberger wrote:
> Am Dienstag, 18. September 2018, 05:58:33 CEST schrieb Masahiro Yamada:
>> Some samples require headers installation, so commit 3fca1700c4c3
>> ("kbuild: make samples really depend on headers_install") added
>> such dependency in the top Makefile.  However, UML fails to build
>> with CONFIG_SAMPLES=y because UML does not support headers_install.
>>
>> Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_install")
>> Reported-by: Kees Cook <keescook@chromium.org>
>> Cc: David Howells <dhowells@redhat.com>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Is there anything UML can do better?
> Not sure whether an arch like is supposed to install headers at all,
> I guess no. :)

As a side note.

OpenWRT/LEDE patches for their build tree patch UML to do so when 
building UML. IMHO it is a hack, but it works.

A.

>
> Thanks,
> //richard
>
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

