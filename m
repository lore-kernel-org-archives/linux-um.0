Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EP76F-0001Qp-Qp	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Oct 2005 16:30:31 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EP76T-00033x-I3
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Oct 2005 16:30:47 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Blank process command lines in 2.6.13.2?
References: <200510091623.34322.rob@landley.net>
	<200510100010.10951.rob@landley.net>
	<20051010143615.GA3448@ccure.user-mode-linux.org>
In-Reply-To: <20051010143615.GA3448@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510101830.23167.rob@landley.net>
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
Date: Mon, 10 Oct 2005 18:30:22 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Monday 10 October 2005 09:36, Jeff Dike wrote:
> I think the worst case is skas3 with no stack randomization, where that
> page will point somewhere into the process stack.  There is some slight
> possibility that something could store a password on its stack, and have
> that end up in the area that the host ps looks for arguments.  This would
> make the password visible on the host for the time that this process in
> context.

I'm not so worried about sensitive info because in the parent kernel you can 
just attach to the process from a debugger (although not necessarily as a 
different, normal user).  I'm actually slightly more concerned about high 
ascii garbage or who knows what showing up and making ps look really weird.

> With stack randomization, the UML process stacks will be located
> elsewhere almost all the time, so with skas3, there is a smaller
> chance that there will be a visible password there.
>
> With skas0, that page is the stub signal stack, which contains no sensitive
> information.

Is there any way to move the stub signal stack on skas0 by one page so that we 
can still have ps on the parent system look right?  I don't know how hard 
that is.  (Is there a design document for -skas0 anywhere?  I found 
the /dev/anon page...)

Rob


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
