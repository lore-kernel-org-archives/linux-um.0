Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7gs9-0007uy-P2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Sep 2004 13:59:25 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C7gs9-00084F-7Z for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Sep 2004 13:59:25 -0700
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2.enterasys.com
	[134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id i8FKxGao019811
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 15 Sep 2004 16:59:16 -0400 (EDT)
Message-ID: <4148AD24.1040408@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [ann] kraxel's 2.6.8 uml patch kit
References: <20040820122445.GA21790@bytesex>
	<200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
	<20040822111745.GA10736@bytesex> <4133C57D.6060201@enterasys.com>
	<20040914123658.GB29562@bytesex>
In-Reply-To: <20040914123658.GB29562@bytesex>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig77E0FB5538E93EB3E7C33677"
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
Date: Wed, 15 Sep 2004 16:59:16 -0400
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77E0FB5538E93EB3E7C33677
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

actually it's worse than that in my current implementation:

static int panic_coreonpanic(struct notifier_block *self, unsigned long 
unused1,
                 void *unused2)
{
    if ( uml_coreonpanic ) {
        /* cleanup so we have less to cleanup [linux] on the host */
        /* could panic in uml_cleanup though so we need a check */
        if ( uml_exitcode++ < 1 ) {
            uml_cleanup();
        }
        /* to prevent keyboard from causing terminal to spew during dump */
        block_signals();
        abort();
    }
    return(0);
}


Gerd Knorr wrote:

>>I liked this too. Here's a pass at it if you like (attached).
>>    
>>
>
>Sorry for the delay, going over this while being busy updating my
>patches right now ...
>
>  
>
>>+static int panic_coreonpanic(struct notifier_block *self, unsigned long unused1,
>>+			     void *unused2)
>>+{
>>+	if(uml_coreonpanic){
>>+		uml_cleanup();
>>+		block_signals();
>>+		abort();
>>    
>>
>
>What is the point of doing that?  I'd just let it dump core without any
>cleanups, to get the state of the uml kernel dumped to the disk with few
>modifications as possible.  Any changes might make the analysis of the
>crash harder or even impossible.
>
>  Gerd
>
>  
>

-- 
db


--------------enig77E0FB5538E93EB3E7C33677
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFBSK0k3XQ4zakZ3z4RAp0wAJ4t/W2Jfd74Y/AUzt0RjduZUTep+ACeJftC
tmkKMcrSI9Cq47h7htgpm2c=
=eXG1
-----END PGP SIGNATURE-----

--------------enig77E0FB5538E93EB3E7C33677--


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
