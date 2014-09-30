Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <patrakov@gmail.com>) id 1XZ2SE-0005gl-Qd
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Sep 2014 18:47:18 +0000
Received: from mail-wg0-f50.google.com ([74.125.82.50])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XZ2SD-0002HE-MW
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Sep 2014 18:47:18 +0000
Received: by mail-wg0-f50.google.com with SMTP id l18so15384397wgh.9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 30 Sep 2014 11:47:11 -0700 (PDT)
Message-ID: <542AFAAC.4090100@gmail.com>
Date: Wed, 01 Oct 2014 00:47:08 +0600
From: "Alexander E. Patrakov" <patrakov@gmail.com>
MIME-Version: 1.0
References: <1412015343.9609.13.camel@localhost.localdomain>
	<CAFLxGvxD=+VxJeGkKS_Ukq5m3KvV5femmhVWYdm1XFYGHauBqw@mail.gmail.com>
	<1412101656.2769.17.camel@localhost.localdomain>
In-Reply-To: <1412101656.2769.17.camel@localhost.localdomain>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [systemd-devel] Timed out waiting for device
	dev-disk-by...
To: Thomas Meyer <thomas@m3y3r.de>, Richard Weinberger <richard.weinberger@gmail.com>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

01.10.2014 00:27, Thomas Meyer wrote:
> Am Montag, den 29.09.2014, 22:20 +0200 schrieb Richard Weinberger:
>> On Mon, Sep 29, 2014 at 8:29 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>>> Hi,
>>>
>>> I get a timeout in the Fedora 21 alpha:
>>>
>>> [ TIME ] Timed out waiting for device dev-disk-by\x2duuid-008af19d\x2d2562\x2d49bd\x2d8907\x2d721ea08f3e14.device.
>>>
>>> But all devices are available from early kernel start:
>>> # ls -l /dev/disk/by-uuid/
>>> total 0
>>> lrwxrwxrwx 1 root root 11 Sep 29 20:17 008af19d-2562-49bd-8907-721ea08f3e14 -> ../../ubda1
>>> lrwxrwxrwx 1 root root 11 Sep 29 20:17 e2bffa45-d84f-47bc-81ba-e7a395751fa6 -> ../../ubda3
>>> lrwxrwxrwx 1 root root 11 Sep 29 20:17 f452f020-a446-41ed-93c0-ee5ce56d6ea4 -> ../../ubda2
>>>
>>> It feels like some event notification is lost in the boot process or something like this?!
>>>
>>> What exactly makes the device unit go into the state active/plugged?
>>>
>>> This is a boot of the Fedora 21 alpha under user mode linux.
>>>
>>> Any ideas what could be wrong here?
>>
>> Please always CC me and/or the UML mailinglist in case of UML related issues.
>> I'm very interested in having UML work with systemd.
>>
> Okay Richard, will do so in future.
>
> Some more info about the above systemd wait (with
> systemd.log_level=debug and DEBUG_KOBJECT)
>
> Systemd starts and installs a job for each device tagged with "systemd":
> Sep 30 18:07:58 localhost systemd[1]: Installed new job dev-ubdb3.device/start as 34
> Sep 30 18:07:58 localhost systemd[1]: Installed new job systemd-fsck@dev-ubdb3.service/start as 35
>
> Sep 30 18:07:58 localhost systemd[1]: Enqueued job initrd.target/start as 1
> Sep 30 18:07:58 localhost systemd[1]: Loaded units and determined initial transaction in 837.189ms.
> Sep 30 18:07:58 localhost systemd[1]: Received SIGCHLD from PID 32 (n/a).
>
> Device unit is waiting:
> Sep 30 18:07:58 localhost systemd[1]: Expecting device dev-ubdb3.device...
>
> udev coldplug:
> Sep 30 18:08:02 localhost systemd[360]: Executing: /bin/dracut-pre-trigger
> Sep 30 18:08:02 localhost dracut-pre-trigger[360]: rd.dm=0: removing DM RAID activation
> Sep 30 18:08:02 localhost systemd-udevd[358]: starting version 215
> Sep 30 18:08:02 localhost dracut-pre-trigger[360]: rd.md.imsm=0: no MD RAID for imsm/isw raids
> Sep 30 18:08:03 localhost dracut-pre-trigger[360]: rd.md.ddf=0: no MD RAID for SNIA ddf raids
> Sep 30 18:08:03 localhost dracut-pre-trigger[360]: rd.md=0: removing MD RAID activation
> Sep 30 18:08:04 localhost kernel: kobject: 'alarmtimer' (00000000930ef220): kobject_uevent_env
> Sep 30 18:08:04 localhost kernel: kobject: 'alarmtimer' (00000000930ef220): fill_kobj_path: path = '/devices/platform/alarmtimer'
> Sep 30 18:08:04 localhost kernel: kobject: 'uml-blkdev.1' (00000000605a1700): kobject_uevent_env
> Sep 30 18:08:04 localhost kernel: kobject: 'uml-blkdev.1' (00000000605a1700): fill_kobj_path: path = '/devices/platform/uml-blkdev.1'
> Sep 30 18:08:04 localhost kernel: kobject: 'ubdb' (000000008c030480): kobject_uevent_env
> Sep 30 18:08:04 localhost kernel: kobject: 'ubdb' (000000008c030480): fill_kobj_path: path = '/devices/platform/uml-blkdev.1/block/ubdb'
> Sep 30 18:08:04 localhost kernel: kobject: 'ubdb1' (0000000093205838): kobject_uevent_env
> Sep 30 18:08:04 localhost kernel: kobject: 'ubdb1' (0000000093205838): fill_kobj_path: path = '/devices/platform/uml-blkdev.1/block/ubdb/ubdb1'
> Sep 30 18:08:04 localhost kernel: kobject: 'ubdb2' (0000000093205638): kobject_uevent_env
> Sep 30 18:08:04 localhost kernel: kobject: 'ubdb2' (0000000093205638): fill_kobj_path: path = '/devices/platform/uml-blkdev.1/block/ubdb/ubdb2'
> Sep 30 18:08:04 localhost kernel: kobject: 'ubdb3' (0000000093205438): kobject_uevent_env
> Sep 30 18:08:04 localhost kernel: kobject: 'ubdb3' (0000000093205438): fill_kobj_path: path = '/devices/platform/uml-blkdev.1/block/ubdb/ubdb3'
>
> So here the udev coldplug triggers the kernel kobject_uevent for 'ubdb3'.
> I don't understand why the systemd unit doesn't change to PLUGGED here! It should?! Or shouldn't it?

Imho the problem is not specific to UML. Something similar has been 
triggered on my desktop PC, and nobody replied:

https://www.mail-archive.com/systemd-devel@lists.freedesktop.org/msg22490.html

If this triggers again, I will provide dumps.

-- 
Alexander E. Patrakov

------------------------------------------------------------------------------
Slashdot TV.  Videos for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

