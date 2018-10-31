Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHrc2-000499-9l
 for linux-um@lists.infradead.org; Wed, 31 Oct 2018 14:36:53 +0000
From: "Li, Philip" <philip.li@intel.com>
Subject: RE: Testing UserModeLinux with kbuild bot
Date: Wed, 31 Oct 2018 14:36:36 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662495131A0E6@shsmsx102.ccr.corp.intel.com>
References: <1924684.J8ZAjWOtys@blindfold> <2576349.EAEpUZHT3j@blindfold>
 <20181031103438.v3vayp4l42fr4fc5@wfg-t540p.sh.intel.com>
 <3096189.L6jIJrMh3q@blindfold>
In-Reply-To: <3096189.L6jIJrMh3q@blindfold>
Content-Language: en-US
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>, "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "kbuild-all@01.org" <kbuild-all@01.org>, lkp <lkp@intel.com>

> Subject: Re: Testing UserModeLinux with kbuild bot
> 
> Fengguang,
> 
> Am Mittwoch, 31. Oktober 2018, 11:34:38 CET schrieb Fengguang Wu:
> > >Is it also possible to test patches which land on our mailinglist?
> >
> > Sure. Subscribe to this?
> >
> >         linux-um@lists.infradead.org
> 
> Yes.
> 
> > >> There are no special settings for UML tree, so the standard build
> > >> tests, static checks, boot tests and runtime tests will be performed.
> > >> Note that there are no UML specific runtime test case.
> > >
> > >Are you interested in rumtime tests?
> > >Actually running a UML is pretty easy.
> > >I can provide some command lines.
> >
> > Philip may help plan the feature. :)
> 
> Cool.
Thanks Richard, can you share some detail for runtime tests? I will
have it in team's TODO list this quarter.

> 
> Thanks,
> //richard
> 
> 


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

