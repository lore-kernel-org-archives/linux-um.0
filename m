Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSBZ1-0001Gz-1I	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 03:20:39 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DSBYw-0002ll-29	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 03:20:38 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] gdb debugging problem on uml-2.6.10
References: <4271073D.3030800@yahoo.com.cn>
In-Reply-To: <4271073D.3030800@yahoo.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505011216.27331.blaisorblade@yahoo.it>
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
Date: Sun, 1 May 2005 12:16:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Mei,Jia" <cfs_eric@yahoo.com.cn>

On Thursday 28 April 2005 17:54, Mei,Jia wrote:
> Hi,
>
> When I try gdb-5.3.90 with uml in vanilla-2.6.10 kernel. I found a problem.
>
> When I set a breakpoint somewhere, and after some step, uml will
> always get a SIGTRAP signal and trap into gdb.
>
> Does anyone met the same problem as me? Any known fix for it?
No, I don't think there is any known fix for it. However, does this problem 
keep on and makes debugging impossible (i.e., after you "cont", does it keep 
stopping)?
> thanks!
>
> Eric
Hmm, are you doing debugging in SKAS or in TT mode? In the second case, then 
it can be a bug in the ptrace proxy (which has a big bug with some gdb 
releases >= 6.0).

In the first case, maybe it's something I observed too (I'm not sure because I 
don't use a lot gdb with UML)... Better, I've observed breakpoints being 
*skipped* by gdb.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
