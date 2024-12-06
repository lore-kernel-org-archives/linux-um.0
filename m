Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14DFE77171
	for <linux-um@archiver.kernel.org>; Fri,  6 Dec 2024 02:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GAk5JhVzNsyey6Ny+41HDC0ZZQqeFg/9i1r0XSbrQ8Q=; b=fR8kFko/+BHDzVvNbUz9S01A/W
	5bqE9wVuVx3sTfZ1pFEexLA3mIBLaM2TQJNFLhcQLnn93cCOZ9unopsNgYQATVc4VdFf+CeuBvN2t
	BR69ygL2+CS4/zqHXFbpubIDbqCLBniCoqbI5OXRJ5YJTDtdabUUcYKlQLrwbeSeWxsy3u4xUAE+i
	OLBWr9PMWYjT44BDb34WOBwDvCA3Sb38258l7YMXdFCl2A3dIFbXw9EqFmDjhDJNT5EHBEkxKa+2X
	k8r0aCR/2OeIwfv+z2zj87csNpRzEiWm67wuiaCni8jc7DobK7BAgid9YKIrbzpwLD541zChmLsID
	GDrZ/1eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJOPn-00000000MlH-1HHq;
	Fri, 06 Dec 2024 02:49:59 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJOPl-00000000Mkp-0DfA
	for linux-um@lists.infradead.org;
	Fri, 06 Dec 2024 02:49:58 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-21572ca3cccso13207165ad.2
        for <linux-um@lists.infradead.org>; Thu, 05 Dec 2024 18:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733453396; x=1734058196; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GAk5JhVzNsyey6Ny+41HDC0ZZQqeFg/9i1r0XSbrQ8Q=;
        b=CcjINywqH1W/XmQ38rAbpfd/GxLhztAL7Pzec1IuWx0JjUZdbOTIsX0TJXn7Vtzu7i
         Trr5z/u0HdyAQP3omu/m+YjcJBGNPS4V1DBvpaM61eqPdYDySKopjlV6/+qflJT+nGxR
         msoRCA9zrg3XFxoPPE4QhwcLpxdQ1PYg6A6I7+D1xnHoxqmWpacfPp78pMsj9loLYjH0
         uxMOjwAidVFWKaoccm4P1ZmXqjHCb+L0YJep6ErqvFzF6GtUTSEAQJHigEYVIzN+V7To
         JcvpWL4PJJgfAiIWqt5QIVv//tYVJRHiLhc4Th3Vlo3l+zorZr5dsad8GUetKZ+rbX/y
         0U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733453396; x=1734058196;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAk5JhVzNsyey6Ny+41HDC0ZZQqeFg/9i1r0XSbrQ8Q=;
        b=WJ1/uxdT7fvawz5ycj7n9RTlJs8MPh+gl2C5ft2ndCcS5EC0iCkVmaqVVKCykntOSE
         qv9Dsc+LWDsvDyUi2Sv+m/wK2nYiwYsPq1w0gvvaYABxsbl9CgNrMEVOcBdOG0YNwWs7
         vKrzcNUPgcTqq//yqL8whF5vqYvUCC3MEKxPuVvHZdF/KOsOlCRcs66gdOKM+Wb8XnED
         0fEZrvplmIgPzPBNRGrbjlfDWNDUmgjdt83cyTwC7ICafOR4JVkRfKR1wjohw4OakRFK
         Pdbab1oTaHqY4qVRqRRa/fAAg44f7dHmKvwD4QS0VkwG6UVqEoDsTSKsxviTMx6PvHy/
         viWg==
X-Gm-Message-State: AOJu0YwH+nkvp9yTEOSuOnHn2iL1LxIDJXBxf/Ri/XJMLODH5nsa1BPO
	Gw2sItvzI9OikygDJ+RhyhNnNsQDb0kaRNTeZbqlEdQZXW0RCBZw
X-Gm-Gg: ASbGncvzwigUDnisCmx2KOBy1ATd/dYWOr64cdzKNfYAQLwmla72DU4QeCW3JbdY87R
	WeAAfQgGVk/M6szMP9l77W4yUFJ8xNA65784NlAmphDAo+getVq7K4s1gvV/YquJDVZ1HcFdHyL
	Jfmuk4RVRZJVMKzNLzXDLeRYaLaDuTI5KZG7zXHu14n5y/jPxuhmYvPbjodM66o3ZGXutK+M2ZO
	DXDj8oL9XrMH5dOMm6caOlMzFfGaEbugGBq8D2bXqOsY4MlB/Ttj1alEiWNSJigl0XgB0dpLBG4
	wNaw3NlBDRUnwnATBI8VBDcKZ4FB+FFuekMg
X-Google-Smtp-Source: AGHT+IHHsRD6A/hZ+gFqbr+erXnUTScsYulU9yEFT7iLwAIkb80ft09xPu3XwhM3QwiBoutQU8VX7Q==
X-Received: by 2002:a17:902:d0d3:b0:215:b190:de6 with SMTP id d9443c01a7336-21614d5461fmr15794905ad.3.1733453395971;
        Thu, 05 Dec 2024 18:49:55 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa218sm19238605ad.139.2024.12.05.18.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 18:49:55 -0800 (PST)
Date: Fri, 06 Dec 2024 11:49:51 +0900
Message-ID: <m2y10tv834.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v3 07/13] x86/um: nommu: process/thread handling
In-Reply-To: <b9115ae2c41429e720af9440d46ebb2614265fff.camel@sipsolutions.net>
References: <cover.1733199769.git.thehajime@gmail.com>
	<7e909114324f92d37dbe0a2f58443cf5ba606c6d.1733199769.git.thehajime@gmail.com>
	<2085ffbd1d5b0a908f26d0ec38a6d8719db5111c.camel@sipsolutions.net>
	<m21pymw7vs.wl-thehajime@gmail.com>
	<b9115ae2c41429e720af9440d46ebb2614265fff.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_184957_093203_F2055B38 
X-CRM114-Status: GOOD (  19.91  )
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


On Thu, 05 Dec 2024 22:58:52 +0900,
Johannes Berg wrote:
> 
> On Thu, 2024-12-05 at 22:56 +0900, Hajime Tazaki wrote:
> > 
> > > > +++ b/arch/x86/um/asm/processor.h
> > > > @@ -38,6 +38,18 @@ static __always_inline void cpu_relax(void)
> > > >  
> > > >  #define task_pt_regs(t) (&(t)->thread.regs)
> > > >  
> > > > +#ifndef CONFIG_MMU
> > > > +#define task_top_of_stack(task) \
> > > > +({									\
> > > > +	unsigned long __ptr = (unsigned long)task->stack;	\
> > > > +	__ptr += THREAD_SIZE;			\
> > > > +	__ptr;					\
> > > > +})
> > > > +
> > > > +extern long current_top_of_stack;
> > > > +extern long current_ptregs;
> > > > +#endif
> > > 
> > > no need for "extern".
> > > 
> > > you only use all that once, does it need to be here?
> > 
> > sorry, I don't understand both of these comments; could you care to
> > elaborate ?
> 
> Sorry, you obviously do need 'extern', I was clearly confused.
> 
> Regarding the task_top_of_stack() macro, I thought you only used it in
> one C file, so I'm not sure it should be in a header file that's
> generally included across the kernel, rather than a private header file
> or just in the C file itself.

I understand, thanks.
I'll move the macro to a different file.

-- Hajime


