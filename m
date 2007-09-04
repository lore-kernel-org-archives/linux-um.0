Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ISXfa-0006qz-GL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Sep 2007 05:38:14 -0700
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ISXfa-0008LH-6w
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Sep 2007 05:38:14 -0700
From: Rob Landley <rob@landley.net>
Date: Tue, 4 Sep 2007 07:37:54 -0500
References: <200708212148.05392.rob@landley.net>
	<200708222047.01962.rob@landley.net>
	<20070823034413.GB17185@c2.user-mode-linux.org>
In-Reply-To: <20070823034413.GB17185@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200709040737.54516.rob@landley.net>
Subject: Re: [uml-devel] UML doesn't build in 2.6.23-rc3.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Wednesday 22 August 2007 10:44:13 pm Jeff Dike wrote:
> On Wed, Aug 22, 2007 at 08:47:01PM -0500, Rob Landley wrote:
> > Does that reproduce it for you?
>
> Yup, but it's somewhat non-obvious why.  Anyway, it seems clear that
> asm-generic/tlb.h is missing an include.
>
> 				Jeff

I still need the patch I posted to build -rc5.  Just FYI.

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
