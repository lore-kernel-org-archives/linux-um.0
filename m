Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iADpM-0001sA-A9
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 13:47:34 +0000
Subject: Re: [RFC v3 2/2] um: implement time-travel=ext
References: <20190917132943.20102-1-johannes@sipsolutions.net>
 <1568726354-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
 <a8a2a033d8dc988c34d321425b7d0baa65b8df81.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <ddaf73a2-762a-91d2-40ab-d432e363d52b@kot-begemot.co.uk>
Date: Tue, 17 Sep 2019 14:47:24 +0100
MIME-Version: 1.0
In-Reply-To: <a8a2a033d8dc988c34d321425b7d0baa65b8df81.camel@sipsolutions.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org


On 17/09/2019 14:35, Johannes Berg wrote:
> On Tue, 2019-09-17 at 15:29 +0200, Johannes Berg wrote:
>>   struct virtio_uml_vq_info {
>>   	int kick_fd, call_fd;
>>   	char name[32];
>> +#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
>> +	struct virtqueue *vq;
>> +	vq_callback_t *callback;
>> +	struct time_travel_event defer;
>> +#endif
> There's a bit of a question here - should I put all these ifdefs?
>
> It *should* compile fine without them, and throw away the unused
> functions, but this structure will still be bigger, and the vq
> initialization will still be done. Everything else should go away since
> time_travel_mode is tested (and is defined to NONE) / empty inlines are
> called if CONFIG_UML_TIME_TRAVEL_SUPPORT isn't set.
>
> Though, come to think of it, I probably broke modular builds again here.

:)

>
> Anyway, I won't send a new version soon I think, comments welcome and
> I'll see how the qemu changes progress.

As I said - I am going to wait for Richard's next PR so I have a settled 
tree and I will get on with testing. I should have a bit more time then 
as well as ONS Europe will be out of the way. At the moment all of my 
time is being eaten by various k8 related stuff for that.

>
> johannes
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

