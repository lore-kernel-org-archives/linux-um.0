Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BZCWn-0002UM-6T for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jun 2004 10:42:49 -0700
Received: from mailgate.uni-paderborn.de ([131.234.22.32])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BZCWl-0003XH-BI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Jun 2004 10:42:47 -0700
Message-ID: <40CB4074.30706@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] [BUG] host fd leak when using hostfs
References: <c9oc52$a3$1@sea.gmane.org>
	<200406121932.43743.blaisorblade_spam@yahoo.it>
In-Reply-To: <200406121932.43743.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sat, 12 Jun 2004 19:42:12 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

>>i mounted the directory /usr/portage from my host into my UML-machine
>>(also to /usr/portage). The directory is mounted read-only. After that,
>>i did "emerge -upD world" which must have accessed many many files.
>>emerge crashed with the exception "too many open files" and indeed, the
>>processes inside the UML cannot open any file anymore.
>>
>>If i do an "lsof" on the host, i see that the kernel-process has still
>>opened many many files from /usr/portage - too many files ;-)
>>
>>So this should be bug in hostfs, so that hostfs doesn't close files on
>>the host if they are closed inside the UML. Is there a fix for that
>>already?
> 
> Try the attached patch (for 2.6 only!), but please be very careful... there 
> could be subtle pitfall in the VFS making it have other problems. However 
> I've well understood what is the difference between 2.4 and 2.6 which makes 
> the difference.
> 
> What is your UML version? I got the same thing with 2.6.4 patch adapted onto 
> 2.6.6 (the 2.6.6-02 distributed on my page).

I think i used 2.6.6-um1 from the official download-page. I should have 
mentioned that in my first POST.

> for i in `find /mnt/usr/bin`; do cat $i >/dev/null; done

i think even "find /mnt/usr/bin" would habe been sufficient to reproduce 
the problem.


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
