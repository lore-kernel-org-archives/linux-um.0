Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CuUOM-0004Xn-Mr for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 03:34:22 -0800
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CuUOK-0006ik-8j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 03:34:22 -0800
Message-ID: <54400.80.203.0.208.1106912056.squirrel@80.203.0.208>
In-Reply-To: <1106908848.25603.10.camel@gandalf.tm.informatik.uni-frankfurt.de>
References: <1106908848.25603.10.camel@gandalf.tm.informatik.uni-frankfurt.de>
Subject: Re: [uml-devel] State of gdkfb ?
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 28 Jan 2005 12:34:16 +0100 (CET)
To: Michael 'Mickey' Lauer <mickey@tm.informatik.uni-frankfurt.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Hi Geert (et.al),
>
> could you be so kind and give me a status update about your uml
> framebuffer patch regarding kernel 2.6? UML in 2.6.11-rc1-mm1 is the
> first version since quite a while that works here. We use it to
> prototype root file systems for our embedded Linux distributions like
> OpenZaurus and familiar Linux.
>
> Thanks for all the work, guys - UML rocks.

I'm not sure, but there were some linking problems I recall, which can be
sorted in easy ways actually. By using an uml_fb helper program, and use
shared memory (either shm, by file, or other ways, and a communatication
channel for update-notifications and keyboard/mouse inputs).


Stian Skjelstad


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
