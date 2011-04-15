Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Fri, 15 Apr 2011 17:17:42 +0200
References: <201104132150.05623.richard@nod.at> <201104141552.42213.richard@nod.at> <COL101-W165ED5CB17434202CE273DE2AD0@phx.gbl>
In-Reply-To: <COL101-W165ED5CB17434202CE273DE2AD0@phx.gbl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201104151717.42534.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] gcc-4.6.0 generates no code for sub_preempt_count()
To: James McMechan <james_mcmechan@hotmail.com>
Cc: mikpe@it.uu.se, linux-kernel@vger.kernel.org, uml devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Donnerstag 14 April 2011, 21:50:13 schrieb James McMechan:
> > > > Any ideas whether this is a gcc or a kernel issue?
> 
> It looks like a gcc error with one of the optimization passes

I've submitted a bug report.

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48623

Thanks,
//richard
