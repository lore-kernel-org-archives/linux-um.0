Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D57FF60FB
	for <linux-um@archiver.kernel.org>; Tue, 31 Mar 2026 10:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BxTB/uJ+me2n+49LPn3eGz+cwIhgwH3wBDq72IXyVtU=; b=gaNiD+azkTb5zwOCUYJ3uUD/nu
	XYyTQkZNSXUPtPnD1LvwThtvI/hsupoNgqsGn9vFdHtLGIPHh7ntO0hJD4IHjXNHEsNOuxGgRYwPa
	BUm5a5kfQDKYj52zYZHd8grWsK9ogX4nLYWKgZcJViBUb1OUegghqkXidyScsT2tTc2uOlz+K1SfK
	GIqxshRVxBFMNAg+HBxvFc6GJAS2sFOjPd4+OY44uV2Gm8CbeRBXBFqlrIUBuboY8/vcL26qlQ6tj
	syuzwD5TRpPq74xGKzROGH9df3uQT69BtKQhC26Rt0bZd+u7/icFD7c4K0ZBuLUAmrguM0vhu3IcD
	BHZnEY6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7WBk-0000000CllZ-1IoZ;
	Tue, 31 Mar 2026 10:19:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7WBg-0000000Clks-3HSd
	for linux-um@lists.infradead.org;
	Tue, 31 Mar 2026 10:19:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 12D5A60120;
	Tue, 31 Mar 2026 10:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3055DC2BCB0;
	Tue, 31 Mar 2026 10:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774952347;
	bh=C63rki2LoaCtMMcuFy7+wQ/l3D0PT2ixs9u9g+JVSpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cewqqc705/lCYbeJKP8sJfsgy3UQsbAl5dtWjwj3Bqq+5JvJtxZdEaQ/i2U4fdZbn
	 EGLOPzUKotyLfHU3UZi+ZT6PW0LYRLXpLWZtqeaGQjEs5aCyXiBX5oOqVN2TiF7lN0
	 5vLl2faf8FxFSFLPHTYdDQ54JeRMfCP1PoYesFRg=
Date: Tue, 31 Mar 2026 12:19:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, achill@achill.org,
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org,
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, linux@roeck-us.net,
	lkft-triage@lists.linaro.org, patches@kernelci.org,
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de,
	shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
Message-ID: <2026033158-choking-confined-75be@gregkh>
References: <20260323134503.770111826@linuxfoundation.org>
 <20260325010401.62938-1-ojeda@kernel.org>
 <fed7d83d-ace7-47b2-acbb-d469c6189722@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fed7d83d-ace7-47b2-acbb-d469c6189722@leemhuis.info>
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

On Mon, Mar 30, 2026 at 07:48:50PM +0200, Thorsten Leemhuis wrote:
> On 3/25/26 02:04, Miguel Ojeda wrote:
> > On Mon, 23 Mar 2026 14:43:41 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > For UML, I am seeing:
> 
> Guenter (now CCed) just reported something similar down in the thread.
> And I got a similar bug report about it as well, which bisected it to
> 49cf34c0815f93 ("unwind_user/x86: Enable frame pointer unwinding on
> x86") [v6.19-rc1, v6.18.17 (b9537a51b65af0)]:
> https://bugzilla.kernel.org/show_bug.cgi?id=221283
> 
> > [...]
> > 
> >   aa7387e79a5c ("unwind_user/x86: Fix arch=um build")
> 
> The users in that bug reported confirmed that this fixed things:
> https://bugzilla.kernel.org/show_bug.cgi?id=221283#c12
> 
> Greg, Sasha, could you pick this up please for 6.18.y?

Now added, thanks.

greg k-h

