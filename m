Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cvo8x-0004gH-AF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Jan 2005 18:51:55 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cvo8w-0002BY-OS
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Jan 2005 18:51:55 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: FC3/i386 root filesystem on ford (x64_64) with
	2.6.4 kernel: cannot setup LDT
References: <Pine.LNX.4.61.0501311817060.5814@sparrow>
	<200502010441.j114fXUt006210@ccure.user-mode-linux.org>
In-Reply-To: <200502010441.j114fXUt006210@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501312049.32427.rob@landley.net>
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
Date: Mon, 31 Jan 2005 20:49:31 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>, Marion Bates <marion.bates@dartmouth.edu>

On Monday 31 January 2005 11:41 pm, Jeff Dike wrote:
> wstearns@pobox.com said:
> > cannot set up thread-local storage: cannot set up LDT for thread-local
> >  storage
> >
> > Kernel panic: Attempted to kill init!
>
> I don't know why you can't get a sash prompt, but this diagnosis looks
> easy.

I've got a good guess why he couldn't get a sash prompt.  The sash binary is 
probably statically linked against the tls library versions.

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
