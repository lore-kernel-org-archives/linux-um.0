Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2b0w-0006Mx-4h for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 11:11:10 -0800
Received: from mail.broadpark.no ([217.13.4.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2b0s-0001pc-Fa for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 11:11:06 -0800
References: <c31sqm$ett$1@sea.gmane.org>
From: Adrian Phillips <adrianp@broadpark.no>
In-Reply-To: <c31sqm$ett$1@sea.gmane.org> (Sven =?iso-8859-1?q?K=F6hler's?=
	message of "Sun, 14 Mar 2004 16:11:56 +0100")
Message-ID: <87u10rjlc0.fsf@grannyogg.localnet>
MIME-Version: 1.0
Subject: Re: [uml-devel] plenty of "/proc/mm map failed" in syslog
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Sun, 14 Mar 2004 20:10:55 +0100
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

>>>>> "Sven" =3D=3D Sven K=F6hler <skoehler@upb.de> writes:

    Sven> While executing it, i got plenty of thos messages in syslog:
    Sven> Mar 14 15:59:01 localhost kernel: 12 Mar 14 15:59:01
    Sven> localhost kernel: map : /proc/mm map failed, err =3D 12 Mar 14
    Sven> 15:59:02 localhost last message repeated 1321 times Mar 14
    Sven> 15:59:02 localhost kernel: 12 Mar 14 15:59:02 localhost
    Sven> kernel: map : /proc/mm map failed, err =3D 12 Mar 14 15:59:02
    Sven> localhost last message repeated 3216 times Mar 14 15:59:02
    Sven> localhost kernel: 12 Mar 14 15:59:02 localhost kernel: map :
    Sven> /proc/mm map failed, err =3D 12 Mar 14 15:59:02 localhost last
    Sven> message repeated 786 times Mar 14 15:59:03 localhost kernel:
    Sven> 12 Mar 14 15:59:03 localhost kernel: map : /proc/mm map
    Sven> failed, err =3D 12

    Sven> I expected perl to get killed or get an "out of
    Sven> memory"-error, cause the UML didn't have swap and only 128MB
    Sven> memory.

Please check the user archives for the last 3 months or google for mm
map failed.

Sincerely,

Adrian Phillips

--=20
Who really wrote the works of William Shakespeare ?
http://www.pbs.org/wgbh/pages/frontline/shakespeare/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
