Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ec2M8-0007fV-LL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 07:04:20 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ec2M7-0001H7-Bf
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 07:04:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id DF452B0605
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Nov 2005 21:07:05 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
	by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11567-01 for
	<user-mode-linux-devel@lists.sourceforge.net>; 
	Tue, 15 Nov 2005 21:07:02 +0000 (GMT)
Received: from ant.internal (88-96-60-221.dsl.zen.co.uk [88.96.60.221])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 99BBAB0590
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Nov 2005 21:07:02 +0000 (GMT)
From: Antoine Martin <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1132067048.3082.23.camel@ant.internal>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] root_fs images
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
Date: Tue, 15 Nov 2005 15:04:08 +0000
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

I've finally started rebuilding root images from scratch (instructions
provided) and adding various other bits of information:
http://uml.nagafix.co.uk/
I will try to finish the RPM based distros soon: FC4, OpenSuse and
Mandriva are not done yet, any help on how to build these 3 (simply, if
possible) would be appreciated - it has to be from scratch...
Is NPTL/TLS support getting close or should I build non-nptl images?
Also, a few have offered to provide mirrors - and seeing that my
bandwidth limits will get saturated pretty quickly, I will probably want
to get that setup before sending out this URL to a wider audience.
I will also add the SELinux pages (work in progress), some more honeypot
resources, a network toolkit image (providing ntop/snort/nmap/etc)
Suggestions and feedback welcome.

Antoine



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
