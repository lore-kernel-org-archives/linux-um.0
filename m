Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJcnC-0003Ux-DW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 11:31:22 -0700
Received: from goliath.nmsrv.com ([69.28.204.18] helo=mail.praize.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BJcnC-0007Kd-2b for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 11:31:22 -0700
Message-ID: <20040430183116.24011.qmail@praize.com>
From: "gboutwel" <gboutwel@praize.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Still can't get an 2.6.6-rcX UML
Content-Type: Text/Plain;
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
Date: 30 Apr 2004 18:31:16 -0000
To: user-mode-linux-devel@lists.sourceforge.net





Blaisorblade wrote:



> Well, something has been *really* been messed up. If I understand

> things  properly, you are able to compile fine a 2.6.5 UML,
right?



You're telling me..  Yes I can compile an 2.6.5 host, an 2.6.5
UML, and an 2.6.6-rc1/2/3 HOST, but not an 2.6.6-rc1/2/3 guest.



> The problem is that:

> a) I think that file should include the "kernelspace" headers...

> however the kludges needed to do it are very fragile when Kbuild
changes a

> bit (this problem has repeatedly showed up against Linux 2.6).



Ok.  If it where including kernelspace headers I don't think
this would be a problem.



> However, things should succeed anyway, BUT

> 

> b) your distro headers are messed up...; the first thing I
see

> is that it uses the 2.6 headers. Now, the missing header should
be located in 

> /usr/include/asm/mach-default/. Probably it is there; however
the

> kernel uses normally a -Iasm/mach-default, so that #include
 works.

> Since one cannot require user programs to add -I to compile,
Debian

> should  symlink everything from /usr/include/asm/mach-default/
into 

> /usr/include;



As I understand it SID installs as it's 'de facto' headers not
2.6, but 2.5.999-test7. See: http://packages.debian.org/unstable/devel/linux-kernel-headers



And it would seem that this area (in kernel headers) has recently
changed (when compared to 2.5) or up to this point UML builds
have been going against kernel provided headers instead of the
2.5 headers debian's shipping.



> i.e.:

> ln -s  /usr/include/asm/mach-default/* /usr/include.

> 



I'll try it, but I had really hoped not to mess with those headers
as it's my understanding that important pieces of code (ie glibc,
etc) are compiled against those headers.



I'll write back to the list whatever I find out.



Thanks,



George



----------------------------

Love to laugh?

Good Clean Jokes at Praize

http://www.praize.com/jokes/



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
