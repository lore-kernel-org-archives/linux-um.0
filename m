Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8iiU-0004tC-Ml for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:09:42 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1C8iiT-0003p1-W9 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:09:42 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] segmentation fault in RH9
References: <20040917083215.BF36EF19F6@relay1.pgi.com.my>
In-Reply-To: <20040917083215.BF36EF19F6@relay1.pgi.com.my>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409181225.24501.blaisorblade_spam@yahoo.it>
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
Date: Sat, 18 Sep 2004 12:25:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "lauchiawen@pgi.com.my" <lauchiawen@pgi.com.my>

On Friday 17 September 2004 10:28, lauchiawen@pgi.com.my wrote:
> Hi,
>
> I still quite new to Linux and I previously used UML in my University study
> and found out it is very powerful.
>
> However, when I tried to install it in my PCs with Red Hat 9, it keep
> giving me segmentation fault and some error I don't really know about. Here
> is an attach of the problem I encounter. Hopefully you can help me with
> that or if you know anybody that you think can help please tell me.
> Thanks 
> you in advance.
First, some policy: 
1) don't send screenshots; copy and paste the text.
2) post such question to the uml-user mailing list; you are not discussing 
development, so please go there.

Also, you are not very clear about your config. Which distro you use for the 
root_fs? Also, have you tried updating to 2.4.24-1 or 2.4.26-3 (don't try 
releases in the middle, they have problems)?
If it is different from the host, and you are trying to use the host binaries, 
this is the problem. Binaries compiled with different glibc's can be 
incompatible. You must make sure to use with those binaries the host 
libraries, like (if you have hostfs mounted on /mnt/host)
LD_LIBRARY_PATH=/mnt/host/lib:/mnt/host/usr/lib /mnt/host/lib/ld-linux.so.2 
<command pathname> 
where command pathname will be like "/mnt/host/something". However, this does 
not work for scripts (you would need to update each line of the script), so 
use:
chroot /mnt/host

(man chroot for more info).

If this is not the problem, try:
- renaming, inside the root_fs, /lib/tls to /lib/notls, or if that does not 
exist you might try renaming /lib/i686 to /lib/noi686 (but probably this 2nd 
renaming does not help).
> Regards,
> chia wen

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
