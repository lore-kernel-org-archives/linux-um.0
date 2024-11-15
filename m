Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC24D68BC3
	for <linux-um@archiver.kernel.org>; Fri, 15 Nov 2024 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Qtg7V8dSuYHfkwA6F/Bejrd5uW1+9PsWFkQYebdX/w=; b=KOni8uw/WPaQurTKe+srjZespE
	2wXPS3FMJ8XndZZSaD40QR/EsdVRTORlFU/1AAERgAlGgltllEqsntEtQ+iCeDP0hWXk0f5aYw0MS
	718WmrgNRf/YYuwAweeGtcSB36MpD6V/CzM8VaCzR9joNwW76E0Yfz9POEG8B9c+g9pEUa3w7PPKZ
	CcegCADuocFx91AtNvcpFZyWr1+f1Y/TDAo2HwdvVX3dtFHoyT4eTBer+jQHe7QymK6fodoXYAO3f
	8adQPfh0jIi3ZQsXa0yMZL4AKsnOIy+hy9M85rwe2/4MOvJlXdwBYpARmIktOadgYrk/QyirrstDC
	AA9Buo9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBxie-000000033QE-2sqD;
	Fri, 15 Nov 2024 14:54:44 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBxic-000000033Pd-0cjL
	for linux-um@lists.infradead.org;
	Fri, 15 Nov 2024 14:54:43 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-21145812538so15829285ad.0
        for <linux-um@lists.infradead.org>; Fri, 15 Nov 2024 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731682481; x=1732287281; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qtg7V8dSuYHfkwA6F/Bejrd5uW1+9PsWFkQYebdX/w=;
        b=OC6ujfZo2xMSWlS/2uW8xol0WU+A9aitmrIyrmX66IyVSQej4wwbvcRsV+hiWoRuft
         tMFbICUM5LTbrDGOGd/YEU9QC9PBXxS172M57NzTn6ds3tVR6HrKXChB/oP6fqS8Uc7x
         ongvuexqSgwbvP6eMEzopb56i5o8MZiN4kxtfgp5p0Ji02MSf2W5XMeuT7b0pmooraYf
         ZT6RG5Mk1V3EEUwipvYGBaUhT05E1pAIiICHB5OJNBAhM+kD7p16l9IRSda1zOWgSuzZ
         ZkeEKSs3Lf/uP8uOSjs7IANONEVDc1gj6hMUX44wC6FfTHfKvn7FhI4lFgE7M8++wnpZ
         OhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682481; x=1732287281;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qtg7V8dSuYHfkwA6F/Bejrd5uW1+9PsWFkQYebdX/w=;
        b=Wgbw9Gvewf+khCok2KA6Aj+oP5EHLRAA94aodAsaIaHmi9zvvZ0TnUWJVHdxGONZCu
         qz0JJfBgpLJgfD2kxXLrjPsFnkfz9tFto6NLQj7GeVpo3ZCuc/GkLiX6Z5sPYT+gqNOi
         iTwNoHbNSmGgdnHTPkcv4pVSDhD8pL3J+CjOCuuzi1Ykq0wuWo1tCiA/zpLxch4x9QPW
         gQ1nM7lkv8E51VMNWu1y0T8UwG4nIM1SAKsM8hKLQYFU+AFb6+s7aK0NcRx1vLOjX1ub
         FG0XE0sqGtSpRK1NCnScQPpsfnQ2Lwqpjzvx7qotnaIm/M0o3NjMAfvCztXPvnX36P6M
         74zg==
X-Forwarded-Encrypted: i=1; AJvYcCUidWEfGJqLyH+Na2RhfMK/HtTpmPiQGRixZUMdctdqTE/RtvVplm9WWoCR/F22mDTmDXoO46t2iQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyEgPLwQFG3PV7mQc/k+L4PKa91CRTyxgr1kwxj8jKavsHnoJpM
	KrBRj36kNJXdTmjBguSa338zvyN6cLnNJsC2LIE63+qVRVoMK1OK
X-Google-Smtp-Source: AGHT+IEYXhsxKzZaoPmilqnNjVXFYD0ulHgwxftsm/gCjKeylt20iJQY88H7xxoFy/ncisJYK7xyjQ==
X-Received: by 2002:a17:902:da92:b0:211:6b21:2370 with SMTP id d9443c01a7336-211d0d77b37mr37147885ad.29.1731682480855;
        Fri, 15 Nov 2024 06:54:40 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f36cafsm13156335ad.149.2024.11.15.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:54:39 -0800 (PST)
Date: Fri, 15 Nov 2024 23:54:34 +0900
Message-ID: <m25xoofsyd.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: anton.ivanov@kot-begemot.co.uk
Cc: johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [RFC PATCH v2 00/13] nommu UML
In-Reply-To: <e60d2240-4205-472f-9fdd-60b90287c97a@kot-begemot.co.uk>
References: <cover.1729770373.git.thehajime@gmail.com>
	<cover.1731290567.git.thehajime@gmail.com>
	<c85bd71e0f4797edf2635cf4059699d1a3862218.camel@sipsolutions.net>
	<e60d2240-4205-472f-9fdd-60b90287c97a@kot-begemot.co.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_065442_185062_3A6B338E 
X-CRM114-Status: GOOD (  15.61  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


Hello Anton,

thanks for the comment.

On Fri, 15 Nov 2024 19:26:07 +0900,
Anton Ivanov wrote:

> > What do others think? Would you use it? What for?
> 
> I always thought of it as "another LKL". In that case, it can be compared
> to LKL on merit and if it is equivalent or better - go into kernel.
> 
> If there is another use case, I will be glad to hear it.

In a high-level view,

the usage is different (no merit/demerit).
LKL is used with userspace binaries, linked with, or dynamically
replaced with the liblinux.so.  LKL has a userspace API derived from
syscall interface, which can be used to bridge LKL-world and
host-kernel world (not specific to Linux host).

This patchset (nommu UML) doesn't change the usage of current UML.

In an internal implementation point of view,

both (LKL and nommu-UML) uses !MMU.  While LKL can be implemented with
MMU-full configuration, we found (the last patch was back in 2021)
that it is not trivial.

LKL has no process model, currently only runs in a single (LKL)
process.  no vfork(2) support.
nommu-UML can host multiple processes with vfork available.

the patch size is:
LKL (last v8 patch): mostly 5k lines of modifications
nommu-UML: 1.2k lines of mods.


I think it looks like similar (as I'm from LKL which also uses !MMU),
but different from various aspects.

let me know if you wish to see more about the comparison.

-- Hajime


