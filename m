Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <32977.82.83.51.111.1110551392.squirrel@82.83.51.111>
In-Reply-To: <35767.82.83.49.235.1109878592.squirrel@82.83.49.235>
References: <36770.128.176.89.137.1109844107.squirrel@128.176.89.137>   
	<Pine.LNX.4.61.0503030913280.31663@simba.math.ucla.edu>
	<35767.82.83.49.235.1109878592.squirrel@82.83.49.235>
From: "Oliver Baltz" <info@OliverBaltz.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] Re: [uml-user] UML freezes at hdd-intensive processes
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
Date: Fri, 11 Mar 2005 15:29:52 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Hi,

my problem still exists: the UML hangs om hdd-intensive processess (like
apt-get dist-upgrade). I tried a lot of things in time:

o tried on 2 machines with different hardware, different Host- and
Guest-Kernels
o CONFIG_BLK_DEV_UBD_SYNC is not set
o tried ext2/reiserfs on the Guest-UML
o when the UML hangs, it does not respond to sysrqs
o SKAS is not patched into the Host-System
o UML has enough swap-space (tried tmpfs, too)
o did an strace: http://home.oliverbaltz.de/transfer/strace-uml-freeze.txt.gz

I followed this HOWTO: http://oliverbaltz.de/index.php?id=101

Any ideas?
Thanks in advance.

Oliver

> Thanks for all your hints but:
>
> @James:
> My UML got 32M and 256M swap. The UML-Host has 448M physical RAM - I think
> it`s enough for UML and Host. Or am I wrong?
>
> @Ginie:
> The .config of my UML says: "# CONFIG_BLK_DEV_UBD_SYNC is not set".
>
> Any other ideas?
> Olli
>
>> On Thu, 3 Mar 2005, Oliver Baltz wrote:
>>
>>> my UML hangs while intensive processes that use the HDD. For example:
>>> rgrep, upgrade,...
>>>
>>> UML-Hostsystem: 2.4.27-1-386, Intel ICH5 SATA 150-Controller
>>> UML: 2.4.26-3um-1
>>
>> I had a similar experience.  I configured the UML with 256MB RAM, and
>> put
>> the image file in /dev/shm (tmpfs).  However, the default size of tmpfs
>> is
>> half your physical memory (256 MB).  When I did a big update, I/O
>> buffers
>> went above 128MB, and UML got what it called a "kernel mode signal 7"
>> (SIGBUS).  Limiting the RAM to 120MB (leaving a little space for
>> overhead
>> and other users) cured the problem completely.  Making tmpfs bigger
>> would
>> also have helped.  But don't enlarge it above swap space plus physical
>> memory, because when you fill it up, there's no space for programs and
>> the
>> host kernel will panic.
>>
>> James F. Carter          Voice 310 825 2897    FAX 310 206 6673
>> UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA
>> 90095-1555
>> Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for
>> PGP
>> key)
>>
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
>




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
