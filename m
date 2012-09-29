Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1TI18k-0005F5-8D
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Sep 2012 17:47:46 +0000
Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TI18j-0001rh-I5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Sep 2012 17:47:46 +0000
Received: by bkcjk7 with SMTP id jk7so3894724bkc.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 29 Sep 2012 10:47:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <COL101-W596EE5B44B0F26AE2B404EE2810@phx.gbl>
References: <1348702738.50639212c887a@postoffice.tpg.com.au>
	<COL101-W596EE5B44B0F26AE2B404EE2810@phx.gbl>
Date: Sat, 29 Sep 2012 19:47:39 +0200
Message-ID: <CAFLxGvx_-_0CGt+VJEiXk_iHaEB33WXNXUr-OEz=NE93LC7Q1w@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] strange behaviour of ubd
To: James McMechan <james_mcmechan@hotmail.com>
Cc: nippur@tpg.com.au, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, Sep 29, 2012 at 7:31 PM, James McMechan
<james_mcmechan@hotmail.com> wrote:
>> Date: Thu, 27 Sep 2012 09:38:58 +1000
>> From: nippur@tpg.com.au
>> To: James_McMechan@hotmail.com
>> Subject: strange behaviour of ubd
>>
>> Hello James,
>> I have been using User Mode Linux since 2004 as virtual lab for studying.
>> I have always used ubdb,c,d and so on to have more than a "bare" file
>> system
>> to play with: a good file system without an access to a cdrom,dvd,usb and
>> so
>> on is not very interesting ( and Internet is not always available).
>> I am a little frustrated because "ubd" is working only for "root_fs" : no
>
> It appears that you are backing your ubd device with a physical drive
> Nothing wrong with that, but it is not a case I use much,
> you should be able to use any virtual block device not backed directly to
> hardware
> virtual drives that are mapped to hardware it appears may need to be fixed
> to
> use an alternate method of finding out how big the drive is and possibly
> fixing
> up the special ioctl calls like eject.
>
>> cdrom, no dvd and so on ( I am using debian squeeze 64bit). I have
>> verified
>> similar behavior with debian testing (kernel 3.2.x). I have been playing
>> with
>> every combination of parameter of activation.
>> The result : linux ubda=root_fs ubdb=/dev/cdrom does not work AT ALL.
>
> I will have to try this, is it only ubdb that is failing or does it take
> down ubda also?
>
>> It worked, I have already used with kernel 2.4.x.
>>
> It used to work when the host system was running 2.4.x for example debian
> running on a real machine and running a UML on top. Correct?
> I have run very recent kernels on top of very old host systems. A 2.4.18
> host
> for example, running a 3.2 UML on top.
>
>>
>> Internet is full of crappy/obsolete stuff.
>> Everyone is avoiding (on purpose i guess) to talk about this: only
>> examples
>> about swap !!!
>>
> No, I expect people just don't think to do it this way very often.
> Last time I backed with physical drives I had a 30 drive RAID array that was
> throwing ICRC errors every day or so and dropping a drive. Since ICRC is
> basically harmless (checksum error on a IDE/SATA cable, it retries) this was
> a hassle for no gain so I ran my recovery inside a UML since it could not to
> it
> in a read only fashion before another ICRC came in and broke the entire
> RAID array.
>
>> I am writing to you because I have found a "dirty" trick and it is working
>> better than expected.
>>
>> file : ubd_kern.c function ubd_add ( ) line number 831 : I have simply
>> enclosed the goto in a comment.
>>
>>
>>
>> 833 err = ubd_file_size(ubd_dev, &ubd_dev->size);
>> 834 if(err < 0){
>> 835 *error_out = "Couldn't determine size of device's file";
>> 836 /* goto out; */ MODIFIED by me !!!!
>> 837 }
>> 838
>>
> Yes, we should have a better solution however.
> Maybe checking the errno and trying a different command to
> find the drive size on physical drives (or virtual drives in a enclosing
> uml)
>
>> well ... is working bloody well.
>>
>> If you want I can be more accurate if this is not enough for you .... ?!?!
>> Please fix this problem ( ... mine is just a trick, of course).
>>
>> Thanks for your attention.
>> Kind Regards.

So, what exactly does not work?
And since when?
Please provide a test case.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
How fast is your code?
3 out of 4 devs don\\\'t know how their code performs in production.
Find out how slow your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219672;13503038;z?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

