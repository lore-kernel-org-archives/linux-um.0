Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IY5VK-0006wA-3s for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Sep 2007 12:46:34 -0700
Received: from scorpius.cttc.es ([84.88.62.197])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IY5VC-0006SV-5u
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Sep 2007 12:46:28 -0700
Message-ID: <46F17B9D.7010404@cttc.es>
Date: Wed, 19 Sep 2007 21:42:21 +0200
From: =?ISO-8859-1?Q?Ferm=EDn_Gal=E1n_M=E1rquez?= <fermin.galan@cttc.es>
MIME-Version: 1.0
References: <46DDAD83.4030004@cttc.es>
	<200709131909.01286.blaisorblade@yahoo.it>
	<46E9A824.3010808@cttc.es>
	<200709181706.22905.p.giarrusso@gmail.com>
In-Reply-To: <200709181706.22905.p.giarrusso@gmail.com>
Subject: Re: [uml-devel] (Workarounded) Hanging using 'iptables -L' in UML
	vm booted with con0=pts
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo Giarrusso <p.giarrusso@gmail.com>
Cc: =?ISO-8859-1?Q?David_?=@sc8-sf-spam2-b.sourceforge.net, =?ISO-8859-1?Q?Fern=E1ndez?= <david@dit.upm.es>, user-mode-linux-devel@lists.sourceforge.net

Dear Paolo,

>> The solution to the problem is using con1 instead of con0, I mean:
>>
>> ./linux ubd0=3D/tmp/root_fs_debug con=3Dnull con1=3Dpts uml_dir=3D/tmp u=
mid=3Drun
>>
>> instead of
>>
>> ./linux ubd0=3D/tmp/root_fs_debug con=3Dnull con1=3Dpts uml_dir=3D/tmp u=
mid=3Drun
> =

> This was con0=3Dpts, I checked your other mail. Right?

Absolutely :)

Best regards,

--------------------
Ferm=EDn Gal=E1n M=E1rquez
CTTC - Centre Tecnol=F2gic de Telecomunicacions de Catalunya
Parc Mediterrani de la Tecnologia, Av. del Canal Ol=EDmpic s/n, 08860
Castelldefels, Spain
Room 1.02
Tel : +34 93 645 29 12
Fax : +34 93 645 29 01
Email address: fermin dot galan at cttc dot es

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
