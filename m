Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ChSxk-00017X-MN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Dec 2004 05:25:04 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1ChSxi-0003em-TK for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Dec 2004 05:25:04 -0800
Message-ID: <41CAC727.9030102@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: [Fwd: Re: [uml-devel] Memory corruption/errors?]
Content-Type: multipart/mixed; boundary="------------010501010801080700030202"
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
Date: Thu, 23 Dec 2004 14:24:55 +0100
To: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Peter <peter.spamcatcher@rimuhosting.com>

This is a multi-part message in MIME format.
--------------010501010801080700030202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I'm forwarding this to the list.

Bodo

--------------010501010801080700030202
Content-Type: message/rfc822; name="Re: [uml-devel] Memory corruption/errors?"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="Re: [uml-devel] Memory corruption/errors?"

Received: from abgzex5e.abg.fsc.net ([172.25.159.229]) by ABGEX01E.abg.fsc.net
	with Microsoft SMTPSVC(6.0.3790.211); 
	Thu, 23 Dec 2004 03:04:19 +0100
Received: from pdbzex1e.pdb.fsc.net ([172.25.96.71]) by abgzex5e.abg.fsc.net
	with Microsoft SMTPSVC(6.0.3790.211); 
	Thu, 23 Dec 2004 03:04:18 +0100
Received: from trolli.pdb.fsc.net ([172.25.97.20]) by pdbzex1e.pdb.fsc.net
	with Microsoft SMTPSVC(6.0.3790.211); 
	Thu, 23 Dec 2004 03:04:17 +0100
Received: from dgate2.fujitsu-siemens.com (pdbgate2d.pdb.fsc.net
	[172.25.96.91])
	by trolli.pdb.fsc.net (8.11.6/8.11.6) with ESMTP id iBN24HA11889
	for <bstroesser@fujitsu-siemens.com>; Thu, 23 Dec 2004 03:04:17 +0100
Received: from rimuhosting.com (69.90.33.248)
	by dgate2.fujitsu-siemens.com with ESMTP; 23 Dec 2004 03:04:17 +0100
X-SBRSScore: 3.5
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAgAAA+sAAAPp
X-IronPort-AV: i="3.88,83,1102287600"; d="scan'208"; a="1195965:sNHT21769836"
Received: from [192.168.1.103] (port-222-152-51-26.fastadsl.net.nz
	[222.152.51.26]) (authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id iBN23q5s015946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Dec 2004 02:03:57 GMT
Message-ID: <41CA9812.2060505@rimuhosting.com>
Date: Thu, 23 Dec 2004 23:04:02 +1300
From: Peter <peter.spamcatcher@rimuhosting.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
CC: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Memory corruption/errors?
References: <63806.222.152.52.159.1103583370.squirrel@222.152.52.159>
	<41C963DC.8060401@fujitsu-siemens.com>
	<41C9D1F0.4000605@rimuhosting.com>
	<41C9E847.2060405@fujitsu-siemens.com>
	<41C9FD81.6000408@rimuhosting.com>
	<41CA0002.6050802@fujitsu-siemens.com>
In-Reply-To: <41CA0002.6050802@fujitsu-siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: peter.spamcatcher@rimuhosting.com
X-OriginalArrivalTime: 23 Dec 2004 02:04:18.0399 (UTC)
	FILETIME=[B5F81EF0:01C4E893]


I really don't know what fxsr is.  But I think I have it.  My servers 
are dual proc xeons.  2.6.8.1 with skas3 v7 (mostly).

# cat /proc/cpuinfo  | grep fxsr
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid

So you can only reproduce the problem when your use the sighandler?  But 
when you use your patch the problem is not triggered (even with the 
sighandler)?

I'd be happy to try a patch.  I only have production machines at the 
moment, so I may not be able to restart one for a week or two until some 
new ones arrive.

Regards, Peter

Bodo Stroesser wrote:
> Peter wrote:
> 
>> I don't run TT mode UMLs.  So, no I haven't tried that.
>>
>> I don't know about the sighandler.  The program runs as it was listed. 
>> It is running on a 'regular' server (Debian, and/or WBL3) with other 
>> processes running.  And the host servers happen to be running other 
>> UMLs.  I don't know if that information helps.  (i.e. can a sighandler 
>> in another process on the UML or on the host cause this problem?)
>>
>> I'd be happy to try out a skas patch - preferably if it just applied 
>> to the guest ;)  To see if it fixes things or not.
>>
>> Regards, Peter
>>
> I could try to create a patch, just for testing.
> What machine is your host? It probably has fxsr?
> 
> Bodo

--------------010501010801080700030202--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
