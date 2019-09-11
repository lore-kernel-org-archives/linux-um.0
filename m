Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i82kn-00041b-Kf
 for linux-um@lists.infradead.org; Wed, 11 Sep 2019 13:33:51 +0000
Subject: Re: [PATCH v5 0/5] um: virtio support
References: <20190911125122.20772-1-johannes@sipsolutions.net>
 <2b6ac17c16113892e27e82df9802264ef934d4d8.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <3ccfa0c9-7b5c-6135-693e-a9700dfdd19f@kot-begemot.co.uk>
Date: Wed, 11 Sep 2019 14:33:38 +0100
MIME-Version: 1.0
In-Reply-To: <2b6ac17c16113892e27e82df9802264ef934d4d8.camel@sipsolutions.net>
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



On 11/09/2019 14:18, Johannes Berg wrote:
> On Wed, 2019-09-11 at 14:51 +0200, Johannes Berg wrote:
>> Yet another respin, with a small fix in the virtio platform data
>> freeing code.
> 
> I'm getting to the "tiny little fixes" territory, so would appreciate if
> you could give it a spin again.
> 
> I think quite possibly much of the issues you saw were just from the
> uninitialized variable we had in one of the early versions, and
> regardless of that the error messages should be more verbose now.
> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 


I will try to find it a timeslot later today or failing that tomorrow 
morning.

Brhds



-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

