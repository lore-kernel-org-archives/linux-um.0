Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2g4v-0008VV-69	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Aug 2005 19:12:25 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E2g4u-00024G-T1
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Aug 2005 19:12:25 -0700
Received: from motgate3.mot.com ([144.189.100.103])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1E2Kcq-000288-21	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Aug 2005 20:18:00 -0700
Received: from az33exr01.mot.com (az33exr01.mot.com [10.64.251.231])
	by motgate3.mot.com (8.12.11/Motgate3) with ESMTP id j793Q0Vp017807
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 8 Aug 2005 20:26:00 -0700 (MST)
Received: from zch07exm01.corp.mot.com (zch07exm01.corp.mot.com [200.3.1.220])
	by az33exr01.mot.com (8.13.1/8.13.0) with ESMTP id j793L4xG009856
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 8 Aug 2005 22:21:05 -0500 (CDT)
Message-ID: <AD266326EC54D9118CE700110A9E2BE205F7384A@zch07exm01.corp.mot.com>
From: Zhu Tom-a2289c <A2289c@motorola.com>
Subject: RE: [uml-devel] NPTL pthread_create() cannot work.
MIME-Version: 1.0
Content-Type: text/plain
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
Date: Tue, 9 Aug 2005 11:12:53 +0800
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

> Hm, ok... there will be probably some trivial reject...I cannot update those patches right now since I haven't enough bandwidth.
On git3/4, cannot make ARCH=um, seems script error.
On git8, cannot run vmlinux. Host needs something?


>> so, I just made my local fix on 2.6.12-rc4.
> Yes, I was probably missing some sleep. Only difference in my patches is that return value is set to set_tls_entry return value (and this matches with i386).
I mean the bug fix of segv problem, when forking, add load_TLS(), ...


>Does the system boots ok in that config, including sshd and apps like MySQL / Apache / Java ? With the previous version of the patches, no TLS data would work for sure... and sshd still doesn't work on my Sarge (which seems particularly picky - other people got success with other distros with much less changes).
I don't know, I am using my rootfs, :-)

> Good catch, thanks, even if this isn't going yet to be the *final* fix (since we aren't likely using the last slot).
I see.

Thanks,
Tom


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
