Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B7EC001DF
	for <linux-um@archiver.kernel.org>; Tue, 25 Jul 2023 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4cFAf3nk2/k7N21CknmGpdF+k+zRqaRi8bZM8CgogZU=; b=lCPML5EYpjWvki
	WFc4KwqgXpwC8dzcOvgUxL20kJXp3q2MGTL0g9Cq0HxIbMX4PHoYcu2sBJlREfFaZz348sw0x8dRG
	3oWGHlmIJsJtC9tTQX/dmRa5Dn+FWhQzyEh0E8gcgcAj5C43wWA2UHN40ALa0Y88nRm3qiaoq35l8
	0FI2MbrJsCajSiIVrxwdIBepSTvypiXOCgW7WnOc2Alw9TgdbMsHKns6vVL8aCQC23g6gxQFsURLp
	CaxqKXjSslLRBYO4gbq2OPUJbJxbE60MU/EU/PE3rsmDrF3ocjq9ygMv0QoJOfzhpwV/gsW5hJp0d
	pbhAyRHrfoIAEXPI49tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOMdZ-008FQ9-1V;
	Tue, 25 Jul 2023 18:19:57 +0000
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qOMdQ-008FPM-33;
	Tue, 25 Jul 2023 18:19:49 +0000
Message-ID: <5e56d4a9-2671-caf7-c267-9beec6f14aa3@infradead.org>
Date: Tue, 25 Jul 2023 11:19:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] um/drivers: Kconfig: fix hostaudio build errors
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Tejun Heo <tj@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
References: <20230723215756.18307-1-rdunlap@infradead.org>
 <87jzuoth7s.wl-tiwai@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87jzuoth7s.wl-tiwai@suse.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 7/25/23 03:31, Takashi Iwai wrote:
> On Sun, 23 Jul 2023 23:57:56 +0200,
> Randy Dunlap wrote:
>>
>> Use "select"s to ensure that the required kconfig symbols are set
>> as expected.
>>
>> This fixes build errors when CONFIG_SOUND is not set.
>>
>> ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_cleanup_module':
>> hostaudio_kern.c:(.exit.text+0xa): undefined reference to `unregister_sound_mixer'
>> ld: hostaudio_kern.c:(.exit.text+0x15): undefined reference to `unregister_sound_dsp'
>> ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_init_module':
>> hostaudio_kern.c:(.init.text+0x19): undefined reference to `register_sound_dsp'
>> ld: hostaudio_kern.c:(.init.text+0x31): undefined reference to `register_sound_mixer'
>> ld: hostaudio_kern.c:(.init.text+0x49): undefined reference to `unregister_sound_dsp'
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Fixes: d886e87cb82b ("sound: make OSS sound core optional")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: lore.kernel.org/r/202307141416.vxuRVpFv-lkp@intel.com
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Cc: Johannes Berg <johannes@sipsolutions.net>
>> Cc: linux-um@lists.infradead.org
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Nicolas Schier <nicolas@fjasle.eu>
>> Cc: linux-kbuild@vger.kernel.org
>> ---
>> v2: don't delete the HOSTAUDIO Kconfig entry (Masahiro)
>>
>>  arch/um/drivers/Kconfig |   10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff -- a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
>> --- a/arch/um/drivers/Kconfig
>> +++ b/arch/um/drivers/Kconfig
>> @@ -111,20 +111,14 @@ config SSL_CHAN
>>  
>>  config UML_SOUND
>>  	tristate "Sound support"
>> +	select SOUND
>> +	select SOUND_OSS_CORE
>>  	help
>>  	  This option enables UML sound support.  If enabled, it will pull in
>>  	  soundcore and the UML hostaudio relay, which acts as a intermediary
>>  	  between the host's dsp and mixer devices and the UML sound system.
>>  	  It is safe to say 'Y' here.
>>  
>> -config SOUND
>> -	tristate
>> -	default UML_SOUND
>> -
>> -config SOUND_OSS_CORE
>> -	bool
>> -	default UML_SOUND
>> -
>>  config HOSTAUDIO
>>  	tristate
>>  	default UML_SOUND
> 
> And now essentially CONFIG_HOSTAUDIO is equal with CONFIG_UML_SOUND.
> Then isn't it better to replace CONFIG_HOSTAUDIO in
> arch/um/drivers/Makefile with CONFIG_UML_SOUND, so that you can drop
> CONFIG_HOSTAUDIO as well?

OK, I'll send a v3 with that change.

thanks.
-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
