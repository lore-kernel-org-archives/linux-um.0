Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmPox-0006Jj-9I for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 23:13:31 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GmPou-0008NP-FW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 23:13:31 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 21 Nov 2006 08:13:14 +0100
References: <22a33e9f0611180345w7ec64513l34424a59e1671479@mail.gmail.com>
In-Reply-To: <22a33e9f0611180345w7ec64513l34424a59e1671479@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611210813.14745.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Problem with newer (>2.6.14) UML kernels hanging
	under Xen DomU/Centos 4.4
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

On Saturday 18 November 2006 12:45, Matt Willsher wrote:
> I've been trying to get UML running under a Xen DomU running Centos
> 4.4, which I understand is a reasonable thing to do.
>
> When I started out I was using a download 2.6.12 kernel and the image
> booted up fine. I then tried 2.6.18.2, which is hanging after VFS:
> Mounted root (ext3 filesystem) readonly. I've had someone check my
> kernel and the image on another machine and it works without problem.
> I've tried some other kernels, and 2.6.14 seemed ok, 2.6.16 wasn't.
>
> I've had some problems with TLS under Xen running Berkely DB, so have
> rebuilt glibc with native threading disabled, but /lib/tls is still
> there because Bdb complains if it's removed.
>
> Below I've give the process list at the time, backtraces of each of
> these processes and the output of the ./linux ubd0=root_fs_router
> command.  Let me know if more output is required
>
> Any help is very much appreciated.

I have two suggestions for you to try:
* reduce CONFIG_HOST_VM_SPLIT for UML guest kernels (Xen consumes part of the 
available memory for UML, which causes crashes)

* try if booting with mode=tt helps - around 2.6.14 or 2.6.15 skas0 support 
was introduced (a very big change!) and become the new default, so that's the 
1st likely culprit.

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
