Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQZjI-0005Wg-Ju for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 15:40:04 -0700
Received: from adsl-b3-72-34.telepac.pt ([213.13.72.34]
	helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQZjI-0007rj-2M for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 15:40:04 -0700
Message-ID: <40ABE244.3040408@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] host context switch reduction
References: <20040229043549.GA8583@ccure.user-mode-linux.org>	
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>	
	<1084831251.1230.4.camel@chartreuse>	
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>	
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
In-Reply-To: <1084987654.2250.4.camel@chartreuse>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 19 May 2004 23:40:04 +0100
To: Laurent Vivier <LaurentVivier@wanadoo.fr>
Cc: Jeff Dike <jdike@addtoit.com>, roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Laurent Vivier wrote:

[..]

| netserver:/usr/src# uname -a
| Linux netserver 2.4.24-sysemu #4 SMP Tue Feb 17 16:43:11 CET 2004 i686
GNU/Linux
|
| netserver:/usr/src# time ./getpid 1000000
|
| real    0m1.763s
| user    0m0.910s

Just want to comment on this.

Benchmarks of syscall performance on systems with TLS and recent glibc
should not use getpid()... I don't know why, but on my system getpid
alone is *very* fast.

(This is wrt the host. UML doesn't do TLS yet)

To benchmark simple syscalls you may get "real" (in the sense that you
can compare the result values to UML/host systems) values with something
like this:

int main()
{
~ long counter=0;
~ int a;
~ while( counter < 10000000)
~ {
~  counter++;
~  a=getppid();
~  a=getgid();
~ }
}

Regards,
Nuno Silva


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAq+JEOPig54MP17wRAvYlAJ9GlJTvsXpf3iuSN/dNtCak9bp09ACgiUnv
N6ZJgS48H7OsQ3yjVhSh9qw=
=GBzz
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
