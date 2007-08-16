Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILlZL-000452-Ir for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 13:03:50 -0700
Received: from pasmtpa.tele.dk ([80.160.77.114])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ILlZI-0002xf-Rm
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 13:03:47 -0700
Date: Thu, 16 Aug 2007 22:04:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20070816200455.GA14424@uranus.ravnborg.org>
References: <20070816162428.GA8128@c2.user-mode-linux.org>
	<1187281856.2663.0.camel@laptopd505.fenrus.org>
	<20070816192639.GA8957@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070816192639.GA8957@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] UML - Add a .note.SuSE section
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Alberto Pires de Oliveira Neto <apon1@terra.com.br>, giedrius@su.lt, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org, Arjan van de Ven <arjan@infradead.org>

On Thu, Aug 16, 2007 at 03:26:39PM -0400, Jeff Dike wrote:
> 
> The crash is in this section:
> 
>   __uml_setup_start = .;
>   .uml.setup.init : { *(.uml.setup.init) }
>   __uml_setup_end = .;

This looks like a classic bug.
You wanted this:
.uml.setup.init : {
	__uml_setup_start = .;
	*(.uml.setup.init)
	__uml_setup_end = .;
}

In this way you are sure __uml_setup_start has same address as start
of section.
With the original code the linker will align the .uml.setup.init section
to the alignment required by the included sections and thus
the label and the actual start address may differ.

	Sam

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
