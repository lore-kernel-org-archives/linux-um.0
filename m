Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiHwn-0006Vj-VG for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 10:46:57 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiHwn-0004XO-Cv for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 10:46:57 -0800
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <Pine.GSO.4.58.0401181833270.921@altair.dur.ac.uk>
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
Date: Sun, 18 Jan 2004 18:46:47 +0000 (GMT)
To: User-mode-linux-devel@lists.sourceforge.net
Cc: Ingo Molnar <mingo@elte.hu>

>* Jeff Dike <jdike@addtoit.com> wrote:
>
>> >  * Any known issues with 2.6.1 kernels?
>>
>> Fewer, now that I got the 2.6.1 patch out.  UML lacks
>> [gs]et_thread_area still, so 2.6 UMLs won't boot new libcs.
>
>hm, are you sure this is the reason why they dont boot? At least the
>ones in Fedora fall back to LinuxThreads if set_thread_area is -ENOSYS.
>Old 2.4 kernels work just fine - UML ought to work fine too.

Originally, the problem was with these calls as UML used to panic rather
than return -ENOSYS. Now however I believe there is no direct connection
between the [gs]et_thread_area calls and the hang that occurs early on in
tt mode for RedHat 9 glibcs if the /lib/tls libraries exist. For FC1
glibcs the hang happens anyway. See an earlier post of mine for more
details of the hang.

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
