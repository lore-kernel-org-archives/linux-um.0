Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bni3F-0002Yp-EE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jul 2004 11:12:17 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bni3E-0001hB-Px for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jul 2004 11:12:17 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] make mrproper leaves some files around ....
References: <OF61F78B76.DD6FCAF5-ON85256ED8.00777608-04256ED8.007798C0@us.ibm.com>
In-Reply-To: <OF61F78B76.DD6FCAF5-ON85256ED8.00777608-04256ED8.007798C0@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407222012.25767.blaisorblade_spam@yahoo.it>
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
Date: Thu, 22 Jul 2004 20:12:25 +0200
Content-Transfer-Encoding: quoted-printable
To: Himanshu Raj <hraj@us.ibm.com>, user-mode-linux-devel@lists.sourceforge.net

Alle 23:48, mercoled=EC 21 luglio 2004, Himanshu Raj ha scritto:
> Hi Folks,
>
> When I do
> make mrproper ARCH=3Dum
>
> executables mk_task and mk_conatant don't go away from arch/um/util. I
> tried putting the following lines in the arch/um/util/Makefile:
>
> clean :
>         $(RM) -f $(host-progs)
>
> mrproper : clean
>
>
> But that doesn't work. I tried finding where I can add a target for CLEAN,
> but I don't understand the new kbuild process really well. Can anyone
> take a shot at this?
Read Documentation/kbuild/makefiles.txt and add something like this:

clean-files :=3D $(host-progs)

I'll do it myself when and if I can...
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
