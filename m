Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhneO-0008Aj-Uq for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Dec 2005 04:35:00 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EhneL-0005no-9a
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Dec 2005 04:35:01 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Blaisorblade's UML binaries - MORE MORE... please
	give us an x86_64 UML
References: <200511272159.38069.blaisorblade@yahoo.it>
	<200511291752.02558.blaisorblade@yahoo.it>
	<1133382741.29332.15.camel@localhost.localdomain>
In-Reply-To: <1133382741.29332.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512011334.44069.blaisorblade@yahoo.it>
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
Date: Thu, 1 Dec 2005 13:34:43 +0100
To: Phill Wombat <uml@webwombat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 30 November 2005 21:32, Phill Wombat wrote:
> Hi Paolo,
>
> Use this to create a new FC4/x86_64 rootfs (modified from umlwiki post).
Can that be added there too? Doing collaborative editing is the Wiki purpose.

> #!/bin/bash
>
> RPM_INSTALL_CHR=./INSTALL
>
> echo " --> Setting up chroot env in $RPM_INSTALL_CHR"
>
> if [ `id -u` = "0" ] ; then
>         mkdir -p \
>                 $RPM_INSTALL_CHR/etc \
>                 $RPM_INSTALL_CHR/dev \
>                 $RPM_INSTALL_CHR/proc \
>                 $RPM_INSTALL_CHR/sys \
>                 $RPM_INSTALL_CHR/var/tmp \
>                 $RPM_INSTALL_CHR/var/cache/yum
>         touch $RPM_INSTALL_CHR/etc/fstab
>         mknod $RPM_INSTALL_CHR/dev/null c 1 3
>         chmod 666 $RPM_INSTALL_CHR/dev/null
>         mount --bind /proc $RPM_INSTALL_CHR/proc
>         mount --bind /sys $RPM_INSTALL_CHR/sys
> #       rpm \
> #               --root $PWD/$RPM_INSTALL_CHR \
> #               --import
> http://fedora.redhat.com/about/security/4F2A6FD2.txt rpm \
>                 --root $PWD/$RPM_INSTALL_CHR \
>                 -Uvh \
>                 --nodeps \
>                 --force \
>                
> http://download.fedora.redhat.com/pub/fedora/linux/core/4/x86_64/os/Fedora/
>RPMS/fedora-release-4-2.noarch.rpm yum \
>                 -y \
>                 -C \
>                 --installroot=$PWD/$RPM_INSTALL_CHR \
>                 groupinstall "Base"
>         umount $RPM_INSTALL_CHR/proc
>         umount $RPM_INSTALL_CHR/sys
> else
>         echo " *** Sorry, you must be root to setup a chroot environment"
>         exit 1
> fi
>
> This is the gpg key installed instead of the commented lines (I couldn't
> find the right key on the fedora web site). It comes from the live
> FC4/x86_64 host with rpm -qa gpg-pubkeys*; rpm -qi gpg-pubkey-db42a60e
>
>
> Name        : gpg-pubkey                   Relocations: (not relocatable)
> Version     : db42a60e                          Vendor: (none)
> Release     : 37ea5438                      Build Date: Thu 25 Aug 2005
> 02:28:19 PM EST Install Date: Thu 25 Aug 2005 02:28:19 PM EST      Build
> Host: localhost Group       : Public Keys                   Source RPM:
> (none)
> Size        : 0                                License: pubkey
> Signature   : (none)
> Summary     : gpg(Red Hat, Inc <security@redhat.com>)
> Description :
> -----BEGIN PGP PUBLIC KEY BLOCK-----
> Version: rpm-4.4.1 (beecrypt-3.0.0)
>
> mQGiBDfqVDgRBADBKr3Bl6PO8BQ0H8sJoD6p9U7Yyl7pjtZqioviPwXP+DCWd4u8HQzcxAZ5
> 7m8ssA1LK1Fx93coJhDzM130+p5BG9mYSWShLabR3N1KXdXQYYcowTOMGxdwYRGr1Spw8Qyd
> LhjVfU1VSl4xt6bupPbWJbyjkg5Z3P7BlUOUJmrx3wCgobNVEDGaWYJcch5z5B1of/41G8kE
> AKii6q7Gu/vhXXnLS6m15oNnPVybyngiw/23dKjSZVG7rKANEK2mxg1VB+vc/uUc4k49UxJJ
> fCZg1gu1sPFV3GSa+Y/7jsiLktQvCiLPlncQt1dV+ENmHR5BdIDPWDzKBVbgWnSDnqQ6KrZ7
> T6AlZ74VMpjGxxkWU6vV2xsWXCLPA/9P/vtImA8CZN3jxGgtK5GGtDNJ/cMhhuv5tnfwFg4b
> /VGo2Jr8mhLUqoIbE6zeGAmZbUpdckDco8D5fiFmqTf5+++pCEpJLJkkzel/32N2w4qzPrcR
> MCiBURESPjCLd4Y5rPoU8E4kOHc/4BuHN903tiCsCPloCrWsQZ7UdxfQ5LQiUmVkIEhhdCwg
> SW5jIDxzZWN1cml0eUByZWRoYXQuY29tPohVBBMRAgAVBQI36lQ4AwsKAwMVAwIDFgIBAheA
> AAoJECGRgM3bQqYOsBQAnRVtg7B25Hm11PHcpa8FpeddKiq2AJ9aO8sBXmLDmPOEFI75mpTr
> KYHF6rkCDQQ36lRyEAgAokgI2xJ+3bZsk8jRA8ORIX8DH05UlMH27qFYzLbT6npXwXYIOtVn
> 0K2/iMDj+oEB1Aa2au4OnddYaLWp06v3d+XyS0t+5ab2ZfIQzdh7wCwxqRkzR+/H5TLYbMG+
> hvtTdylfqIX0WEfoOXMtWEGSVwyUsnM3Jy3LOi48rQQSCKtCAUdV20FoIGWhwnb/gHU1BnmE
> S6UdQujFBE6EANqPhp0coYoIhHJ2oIO8ujQItvvNaU88j/s/izQv5e7MXOgVSjKe/WX3s2Jt
> B/tW7utpy12wh1J+JsFdbLV/t8CozUTpJgx5mVA3RKlxjTA+On+1IEUWioB+iVfT7Ov/0kcA
> zwADBQf9E4SKCWRand8K0XloMYgmipxMhJNnWDMLkokvbMNTUoNpSfRoQJ9EheXDxwMpTPwK
> ti/PYrrL2J11P2ed0x7zm8v3gLrY0cue1iSba+8glY+p31ZPOr5ogaJw7ZARgoS8BwjyRymX
> Qp+8Dete0TELKOL2/itDOPGHW07SsVWOR6cmX4VlRRcWB5KejaNvdrE54XFtOd04NMgWI63u
> qZc4zkRa+kwEZtmbz3tHSdRCCE+Y7YVP6IUf/w6YPQFQriWYFiA6fD10eB+BlIUqIw80Vgjs
> BKmCwvKkn4jg8kibXgj4/TzQSx77uYokw1EqQ2wkOZoaEtcubsNMquuLCMWijYhGBBgRAgAG
> BQI36lRyAAoJECGRgM3bQqYOhyYAnj7hVDY/FJAGqmtZpwVp9IlitW5tAJ4xQApr/jNFZCTk
> snI+4O1765F7tA==
> =3AHZ
> -----END PGP PUBLIC KEY BLOCK-----
>
> On Tue, 2005-11-29 at 17:52 +0100, Blaisorblade wrote:
> > On Tuesday 29 November 2005 13:22, Phill Wombat wrote:
> > > Hi Paolo,
> > >
> > > x86_64 binary.
> > >
> > > So far so good!
> >
> > Thanks, I have no 64-bit FS to test it. Btw, there's also some other site
> > with binaries:
> >
> > http://uml.harlowhill.com/index.php/PrecompiledKernels
> >
> > http://uml.nagafix.co.uk/
> >
> > > I have managed to create an FC4/x86_64 rootfs from the very impressive
> > > (and amazingly simple) shell script on umlwiki where the entire distro
> > > is installed via yum. Had some trouble with gpg keys though.
> > >
> > > The rootfs starts up and hangs at the usual places to do with consoles
> > > etc. I'll get to doing some hacks on the rootfs to get things going.
> > >
> > > Thanks again
> > > Phill.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
