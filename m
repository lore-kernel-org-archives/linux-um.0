Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bi55o-0006cg-Br for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jul 2004 22:35:40 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1Bi55o-0008NM-31
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jul 2004 22:35:40 -0700
Received: from SCG2 (c-67-160-159-191.client.comcast.net [67.160.159.191])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 7EC872A3A5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  6 Jul 2004 22:35:34 -0700 (PDT)
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Subject: RE: [uml-devel] uml_mconsole issue
Message-ID: <IFEIKNDOLFNCKMGAENCFIEHPCHAA.Anthony_Brock@ous.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <OJEEKGNKKDLJIEPBEJMIMEDGCAAA.Anthony_Brock@ous.edu>
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
Date: Tue, 6 Jul 2004 22:35:29 -0700
To: user-mode-linux-devel@lists.sourceforge.net

Correction, I am seeing an error message on the console. From a "clean"
startup, it took four request for the contents of /proc/uptime before the
console displayed this:

dns2 login: Kernel panic: Segfault with no mm


As you can see, it was sitting at a login prompt during the issue. Also,
unlike previous times, the uml_mconsole command appeared to "freeze" until I
presses CTRL-C. Ideas?

Tony

> -----Original Message-----
> From: user-mode-linux-devel-admin@lists.sourceforge.net
> [mailto:user-mode-linux-devel-admin@lists.sourceforge.net]On Behalf Of
> Anthony Brock
> Sent: Tuesday, July 06, 2004 10:14 PM
> To: user-mode-linux-devel@lists.sourceforge.net
> Subject: [uml-devel] uml_mconsole issue
>
>
> I've been writing some scripts to probe my UML instances for simple
> statistics. However, after a few probes my UML instances crash.
> Specifically, I am issuing commands such as:
>
> $ uml_mconsole bind2 proc uptime
> OK 190.57 162.44
>
> $
>
> About 4 out of 5 times, this will perform successfully. However, this will
> occasionally return successfully (with the correct uptime) BUT the UML
> instance will no longer be running. The exit appears the be totally silent
> (no error messages, no warning and no running linux processes).
>
> My setup is as follows:
>
>
> Host:
> SuSE 9.1 Professional 32-Bit, 2.6.4-54.5-smp (stock kernel with SKAS mode
> enabled)
>
> Guest:
> Image: SuSE 9.0 Professional
> Kernel: linux-2.6.7 with uml-patch-2.6.7-01 and
> uml-linux-2.6.7-01-bb1.patch
> applied.
> Config: See attached
>
>
> Let me know if you require more detail and what specific steps I
> should take
> to help trouble-shoot this. Thanks in advance!
>
> Tony
>



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
