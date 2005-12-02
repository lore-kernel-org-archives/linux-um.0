Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EiDm8-0008P2-Dn for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 08:28:44 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EiDm3-0000hH-R1
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 08:28:44 -0800
From: Rob Landley <rob@landley.net>
References: <20051202001358.GA12204@ccure.user-mode-linux.org>
In-Reply-To: <20051202001358.GA12204@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512021028.26994.rob@landley.net>
Subject: [uml-devel] Re: Stop the insanity
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
Date: Fri, 2 Dec 2005 10:28:26 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 01 December 2005 18:13, Jeff Dike wrote:
> I'm sending this mail out to everyone that I can find who has had the UML
> stubs compiled in unexpected ways, resulting in crashing.
>
> I'd like testing of the patch below on as many gcc versions as possible.  I
> think this patch avoids the fundamental issue which is behind this, namely
> gcc using the stack when we have just replaced it, behind gcc's back.  The
> remapping and storage of the return value is hidden in a blob of asm,
> hopefully giving gcc no room for creativity.
>
> The patch changes both i386 and x86_64 and I'd appreciate testing on both
> architectures.  It's against -rc3, but should go cleanly against -rc4 as
> well.
>
> Please report back both successes and failures.

Seems to work ok on Ubuntu with gcc 3.3.5...  The x86-64 PLD build broke but 
that's just the /lib64 issue, patch that...  The result works just fine there 
too.

Thumbs up.

(My gcc 4.0+uClibc build system died with a header file issue trying to build 
-rc4.  I'll track that down later, but it's not related to this patch.  Might 
easily be something wrong on my end...)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
