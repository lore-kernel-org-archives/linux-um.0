Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhzIO-0002j1-1T for User-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 14:52:00 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhzIN-0004wH-H5 for User-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 14:51:59 -0800
Received: from mercury.dur.ac.uk (mercury.dur.ac.uk [129.234.4.40])
	by hermes.dur.ac.uk (8.11.7-20030923/8.11.7) with ESMTP id i0HMpsn01190
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Jan 2004 22:51:54 GMT
Received: from altair.dur.ac.uk (altair.dur.ac.uk [129.234.4.14])
	by mercury.dur.ac.uk (8.12.10+Sun/8.11.7) with ESMTP id i0HMppg8009639
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Jan 2004 22:51:51 GMT
Received: from localhost (dit0may@localhost)
	by altair.dur.ac.uk (8.11.7+Sun/8.11.1) with ESMTP id i0HMpp720248
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Sat, 17 Jan 2004 22:51:51 GMT
From: M A Young <m.a.young@durham.ac.uk>
Subject: [uml-devel] Re: cannot compile 2.6.1 uml-kernel, NPTL?
Message-ID: <Pine.GSO.4.58.0401172244290.19712@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sat, 17 Jan 2004 22:51:51 +0000 (GMT)
To: User-mode-linux-devel@lists.sourceforge.net

>> gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free
>> -Wl,--wrap,calloc \
>>         -o linux arch/um/main.o vmlinux -L/usr/lib -lutil
>
>Since the only file that's included is /usr/lib/libutils.so and this
>file is part of glibc, i believe that it's my NPTL-patched glibc.
>
>Can somebody with installed NPTL confirm the problem?
>
>BTW: i'm using glibc 2.3.2

I think I saw something similar to your original error when playing with
linking against an nptl enabled libc.a, but I can't remember the details.
I suspect NPTL has some header differences.

It is however worth starting again from a clean kernel tree to make sure
it is not old .o files causing the problems.

	Michael Young


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
