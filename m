Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <32921.83.129.31.196.1110575910.squirrel@83.129.31.196>
In-Reply-To: <200503111102.54214.rob@landley.net>
References: <36770.128.176.89.137.1109844107.squirrel@128.176.89.137>
	<35767.82.83.49.235.1109878592.squirrel@82.83.49.235>
	<32977.82.83.51.111.1110551392.squirrel@82.83.51.111>
	<200503111102.54214.rob@landley.net>
Subject: Re: [uml-devel] Re: [uml-user] UML freezes at hdd-intensive processes
From: "Oliver Baltz" <info@OliverBaltz.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
Date: Fri, 11 Mar 2005 22:18:30 +0100 (CET)
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Hi Rob,

> Is it write-intensive, read-intensive, combination of both, or either one?

I think it is a combination of both: When installing just one single
debian-package the UML often freezes :-(

Is there an alternative to UBD?

Oliver


> On Friday 11 March 2005 09:29 am, Oliver Baltz wrote:
>> Hi,
>>
>> my problem still exists: the UML hangs om hdd-intensive processess (like
>> apt-get dist-upgrade). I tried a lot of things in time:
>>
>> o tried on 2 machines with different hardware, different Host- and
>> Guest-Kernels
>> o CONFIG_BLK_DEV_UBD_SYNC is not set
>> o tried ext2/reiserfs on the Guest-UML
>> o when the UML hangs, it does not respond to sysrqs
>> o SKAS is not patched into the Host-System
>> o UML has enough swap-space (tried tmpfs, too)
>> o did an strace:
>> http://home.oliverbaltz.de/transfer/strace-uml-freeze.txt.gz
>>
>> I followed this HOWTO: http://oliverbaltz.de/index.php?id=101
>>
>> Any ideas?
>> Thanks in advance.





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
