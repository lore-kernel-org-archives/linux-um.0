Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EXRJn-0005Rt-KZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Nov 2005 14:42:55 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EXRJh-0003lC-Sh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Nov 2005 14:42:55 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Uml left showstopper bugs for 2.6.14
References: <BAY101-F4507935C4D38603757606B66E0@phx.gbl>
In-Reply-To: <BAY101-F4507935C4D38603757606B66E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022347.37645.blaisorblade@yahoo.it>
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
Date: Wed, 2 Nov 2005 23:47:37 +0100
To: Kai Tan <mineown@hotmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 22:44, Kai Tan wrote:
> I tried the first patch, got the following error:
>
> Kernel panic - not syncing: copy_context_skas0 : failed to wait for
> SIGUSR1/SIGTRAP, pid = 7182, n = 7182, errno = 0, status = 0xb7f
Ok, segmentation fault, again:
$ ./testprogs/waitstatus $[0xb7f]
WSTOPSIG(status) is 11
The signal is: Segmentation fault

> I got the same error even after applying the second patch.
Oh, sorry.
Can you just try doing a "make clean" and forcing a full recompilation? In any 
case, I will try investigating further... I'll probably request you to give 
me the complete binary (without debug info and compressed) along with 
your .config. Please save them for now, I must check further before...

For now, IIRC you can keep running with mode=tt, right?

> My run command is the following:
>
> linux stderr=1 ubd0=../../root_fs.rh-7.2-full.pristine.20020312

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
____________________________________
Con Yahoo! Mail proteggi la tua casella di posta da virus e posta indesiderata
http://mail.yahoo.com




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
