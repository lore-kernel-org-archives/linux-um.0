Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ayfnq-0002Zs-7t for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 15:29:26 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ayfaf-0002Ag-BH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 15:15:49 -0800
Message-ID: <0d4701c40176$44e14840$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] Re: Hang at ipv4 setup is a cpufreq issue!
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
Date: Thu, 4 Mar 2004 00:21:33 +0100
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: uml-user <user-mode-linux-user@lists.sourceforge.net>

see: http://www.redhat.com/archives/fedora-test-list/2003-July/msg01141.html

maybe this is valuable information for all "underclockers" of you :)

regards
roland



----- Original Message -----=20
From: "roland" <for_spam@gmx.de>
To: "BlaisorBlade" <blaisorblade_spam@yahoo.it>; <user-mode-linux-devel@lis=
ts.sourceforge.net>; "Jeff Dike" <jdike@addtoit.com>
Cc: "uml-user" <user-mode-linux-user@lists.sourceforge.net>
Sent: Thursday, March 04, 2004 12:11 AM
Subject: Hang at ipv4 setup is a cpufreq issue!


> hi paolo,
> no - this doesnt help fixing the "hang at NET:..." bug.
>
> but the mail from jonathan boler gave the essential hint and i tried furt=
her.
> conclusion: this bug indeed seems to be related to cpu frequency!
>
> so - what did i do ?
>
> i did an
> "modprobe p4-clockmod"
> and then
> "echo 0%40%50%performance >/proc/cpufreq"
> to reduce the speed of my 2.6 ghz p4 (40% minimum, 50% maximum)
>
> and........
>
> THE UML STARTS FINE AND THE HANG AT IPV4 SETUP IS GONE!
>
> so - this is the workaround.
>
> now we need a patch ;)
>
> do we need the so called "rtc fix" ?
> does it exist already for 2.6 kernel ?
>
> regards
> roland
>
>
>
> ----- Original Message -----=20
> From: "BlaisorBlade" <blaisorblade_spam@yahoo.it>
> To: <user-mode-linux-user@lists.sourceforge.net>
> Sent: Tuesday, March 02, 2004 8:05 PM
> Subject: Re: [uml-user] Hang at ipv4 setup
>
>
> Alle 11:07, luned=EC 1 marzo 2004, Jonathan Boler ha scritto:
> > I was just wondering if there has there been any progress in fixing the
> > hang at NET: Registered protocol family 2 bug ?
> >
> > Is there a patch available ?
> >
> > Thanks
> >
> > Jonathan
>
> Yes. At least, it should work (that is a fix for what we think is another
> symptom of the your bug). Get these two patches and apply them with patch=
 -l
> -p1 (it is a little mangled for spaces by the mailer). So, please report =
even
> if you get success. If you have any problem, try using only the first one.
>
> http://marc.theaimsgroup.com/?l=3Duser-mode-linux-devel&m=3D1077817911238=
23&w=3D2
>
> http://marc.theaimsgroup.com/?l=3Duser-mode-linux-devel&m=3D1076991685127=
07&w=3D2
> --=20
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729
>
>
>
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id438&op=3Dick
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
