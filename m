Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1AFCD3445
	for <linux-um@archiver.kernel.org>; Fri,  8 May 2026 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2d+btvIUAz8NnrJlvXGD2gsxPIw5HclLnbw66tpZ7ok=; b=dqeIeKgFRrGQoXs2z+o3rHnWsn
	bEp5riFyTNUFrex5pB5FKN77KSiS1NHjIhffKiACmyvhkCk1K5Mui+FWfDxn41iWd0mfEu3J2b7Hh
	WqnFGAFf9g8GiCmjQ1ODz20xHHiFfeE1gY8rgVx4ghdvV8Zv82rvvV3GNxgrEj9FbzW6VIPdOjaVm
	oQ3Dvc/H9wrTeKHMt7DZDR9Z24rkXDkrm8L6nCHTZhS96eeAWhpz8PQk7Bn0US23V0qTaBBShLlz0
	JifZKH3n7i3rKyzuOMaKJogWSNmAaimR0oTyRuQZfRWznluXYJgqHe+qX8N7CoVsY+9WRFtVXEH+s
	WlxYpB0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLTtj-00000007fKJ-3aOH;
	Fri, 08 May 2026 22:42:19 +0000
Received: from vps0.lunn.ch ([156.67.10.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLTth-00000007fJF-13kp
	for linux-um@lists.infradead.org;
	Fri, 08 May 2026 22:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2d+btvIUAz8NnrJlvXGD2gsxPIw5HclLnbw66tpZ7ok=; b=toRQxW+DQCL7hteB8tzITi2u6I
	4fAc1d8h3ZtXYln64m9SR4hXNN+hS6uzM9yGB4MfubhJ0sExiDLuDb+ZuBu6TevjXPvf4rn7hO5/e
	NOa7Lb2yYeJlAhMvl6t5nICMuhlSvAedIGDysJLGav7ffqotoKcqcweivC5YA6vjOfbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wLTtG-002294-UC; Sat, 09 May 2026 00:41:50 +0200
Date: Sat, 9 May 2026 00:41:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Adrien Reynard <reynard.adrien.08@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"open list:KASAN" <kasan-dev@googlegroups.com>,
	"open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
Message-ID: <3c6cde1a-9ce0-4d63-ba89-820c596cff3e@lunn.ch>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
 <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_154217_314902_62EE8E02 
X-CRM114-Status: GOOD (  24.00  )
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

On Fri, May 08, 2026 at 11:23:43AM -0600, Shuah Khan wrote:
> On 5/8/26 10:38, Adrien Reynard wrote:
> 
> Missing commit log
> 
> > Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> > ---
> >   Documentation/dev-tools/kasan.rst                   | 2 +-
> >   Documentation/networking/switchdev.rst              | 2 +-
> >   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
> >   3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> > index 4968b2aa60c8..3a8bd40ad905 100644
> > --- a/Documentation/dev-tools/kasan.rst
> > +++ b/Documentation/dev-tools/kasan.rst
> > @@ -392,7 +392,7 @@ reserved to tag freed memory regions.
> >   If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
> >   will not be enabled. In this case, all KASAN boot parameters are ignored.
> > -Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
> > +Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being
> 
> This is correct the way it is - no need to change this. "results in in-kernel"
> 
> >   enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
> >   support MTE (but supports TBI).
> > diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> > index 2966b7122f05..948bce44ca9b 100644
> > --- a/Documentation/networking/switchdev.rst
> > +++ b/Documentation/networking/switchdev.rst
> > @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
> >   monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
> >   bond will see its upper master change.  If that bond is moved into a bridge,
> >   the bond's upper master will change.  And so on.  The driver will track such
> > -movements to know what position a port is in in the overall topology by
> > +movements to know what position a port is in the overall topology by
> 
> This looks fine.

Fine as in the change is correct, or fine in that the original is
correct and the change is wrong?

Because the change is wrong, there should be two in's here. Please
search the archive for an explanation why.

This is the second time in a week i've had to deal with "improvements"
like this actually breaking stuff. Which also shows that the submitter
did not search to see if somebody has tried to fix this once already,
and failed.

Can we get the tool changed to add a warning, something like:

  WARNING: This tool uses very simple pattern matching to look for
  repeated words. It does not understand the complexity of English,
  and will often result in false positive reports. Please assume it is
  wrong until proven otherwise.

       Andrew

