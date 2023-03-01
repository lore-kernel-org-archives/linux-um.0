Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBE6C64EC7
	for <linux-um@archiver.kernel.org>; Wed,  1 Mar 2023 00:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i73+SPDwg2uSWZr4YGEU/sj89QauIpip9BUy5FjBZAQ=; b=4gGzzZjwPUVQKK
	otB1p05g72QZu1/44mqzPYHeIkPknDZpy2B4LV1CR5yeWS8JbdZhqu6b3cmw4Wp0a9IpHcNNXIbEa
	y4DhIQZMH9tMLSuKu+yC6yvEnKUd+zll8G5KLT9jwhwXFl+AWbdNEgFb2gc9UvIDd8yThCIg8N+Gf
	rytlnEIY71aX1lqoX8fXOeqI9M2K9lTQI9VufLfnXb2e4MulY47oXF4e4gPo3PZJ8QgNJhfPnlD9U
	mylixAHpajQv1nhBfP9Y6TR3EOiqX4JFYFc2wPqElE9kDv+8uHAd/J2ljGgSVjjENAZBLse1Auj0H
	2YOi0pP8vs7XzZNOPQsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXAYA-00EgKH-Sd; Wed, 01 Mar 2023 00:42:30 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXAY8-00EgII-Ew
	for linux-um@lists.infradead.org; Wed, 01 Mar 2023 00:42:30 +0000
Received: by mail-qt1-x82d.google.com with SMTP id c18so12647842qte.5
        for <linux-um@lists.infradead.org>; Tue, 28 Feb 2023 16:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112; t=1677631344;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OEuFOMvrP8BBHdwKphTAWDUEHMPovzNb7xNwVcqUU+o=;
        b=D7XzojXvdADl+xJE/I6wje/HEozWC36M5cIg1/qEOztHyZPFGel08SeO/7CKnCKIVt
         Fx5yGq0nv4nfqV3VmjAJ5WlTNgYNYp6315eSdQ+BlOZz4pQhR4wTpGYNuOlj7Z3XAGrx
         diDbufaH4UwLC0AySnd5R7Z9VdsQqAMM17kddClD4MBC/C9crYekeWcmEGVDDIy1Ahhs
         XvFJBU/3qMpAAe0NizLrk4t4W+E+eAlNHAruAvMIHeEa5Y9CCSh/eNMHH+IlZkbPZ+5Z
         RHnOoUeukE7gS5eh//85if7Xmatx2eNGp8hxoyf6yHnp1wiEX5+8OQRrWbrO7XAsEU4S
         oq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677631344;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEuFOMvrP8BBHdwKphTAWDUEHMPovzNb7xNwVcqUU+o=;
        b=kvHfe2srRRfWoR7ZE6OVEvna2LP5T4mIZfy2+2w0BuoEIscsmxGcTNozV1iWkwNWFV
         zXwHxswU3vlpBtr/2HhDgMHbyzqz99qQBbrGh+K02HjurS2Jt+3HMz0xsuMmjSoZqjWs
         qtUpbZySB1xWhOZWsMBcS282mDf3lcc5rTveGTonsu9RkppHNCEzna5bE8rm1mzJe3nJ
         kvxOzADpIBWJbILjHnHNmD2kOTHBw62Usc2Ke1XyulDrJO0RFMjzMsGds4Mb4Z8Ah1ON
         LQFIylSuafKFipL3XmRK9aEplsLwnbMWV7F0ZuPeen3AK2jgLim5Ng1GovtxsMv0fSxR
         R1yw==
X-Gm-Message-State: AO0yUKWMdzFV2SQzKWHIShoRGBEZag8PTXDPkmbcb4UOcx145mO7f4cz
	V655sI1ODpUUy0JFVq9deFqxDesGIbYsKHr6
X-Google-Smtp-Source: AK7set/saQzZ6RXPtdq0Yoh55sbfEqVx1m5YtxEEMeavQfFIGro4VXv8WR4YX+y983l+tILJFrI6cA==
X-Received: by 2002:ac8:4904:0:b0:3bf:bb92:76bb with SMTP id e4-20020ac84904000000b003bfbb9276bbmr5979464qtq.40.1677631344091;
        Tue, 28 Feb 2023 16:42:24 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id q18-20020ac87352000000b003bfaff2a6b9sm7385525qtp.10.2023.02.28.16.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:42:23 -0800 (PST)
Date: Tue, 28 Feb 2023 18:42:16 -0600
From: Glenn Washburn <development@efficientek.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>, Richard Weinberger
 <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
 <anton.ivanov@kot-begemot.co.uk>, Seth Forshee <sforshee@kernel.org>
Subject: Re: Which branch should this patch be based against?
Message-ID: <20230228184216.09e96361@crass-HP-ZBook-15-G2>
In-Reply-To: <20230228090142.y4dcxxzdkycbyobj@wittgenstein>
References: <20230128014159.1741728-1-development@efficientek.com>
	<20230227103336.6bd56246@crass-HP-ZBook-15-G2>
	<20230228090142.y4dcxxzdkycbyobj@wittgenstein>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_164228_745393_3FACE9F3 
X-CRM114-Status: GOOD (  18.10  )
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
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, 28 Feb 2023 10:01:42 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Mon, Feb 27, 2023 at 10:33:36AM -0600, Glenn Washburn wrote:
> > Hi,
> > 
> > On Fri, 27 Jan 2023 19:41:59 -0600
> > Glenn Washburn <development@efficientek.com> wrote:
> > 
> > > Let hostfs handle idmapped mounts. This allows to have the same
> > > hostfs mount appear in multiple locations with different id
> > > mappings.
> > 
> > This patch is based off of linux-next in the Richard's UML repo[1].
> > However, I've noticed that this patch needs some modifications to be
> > applied against the tip[2]. So I'm wondering which branch in what
> > repo is best to base patches from?
> 
> Hey Glenn,
> 
> Linus merged my pull request that introduces a dedicated new type for
> idmapped mounts into the vfs: struct mnt_idmap. So any branch you base
> this on should contain that work. Let me know if you need help with
> the conversion.

Hi Christian,

I was about to ask for help yesterday when I was trying to figure it
out, but I think I got it working. However, you probably will have
suggestions for improvement. I'll send an updated version soon, and
make sure you're explicitly included.

Glenn

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
