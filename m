Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgggn-0001Xb-0s
 for linux-um@lists.infradead.org; Sun, 22 Nov 2020 04:09:25 +0000
From: Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] um: ubd: Submit all data segments atomically
References: <20201025044139.3019273-1-krisman@collabora.com>
 <7c1bf8c3-0e80-ab90-778c-c124fab3f747@cambridgegreys.com>
 <87pn4atlbk.fsf@collabora.com>
 <CAFLxGvwS6b5Ua9VBaOGS5iYZVd5rYFi=W_VBMxFj5hgSHk__Tw@mail.gmail.com>
Date: Sat, 21 Nov 2020 23:09:18 -0500
In-Reply-To: <CAFLxGvwS6b5Ua9VBaOGS5iYZVd5rYFi=W_VBMxFj5hgSHk__Tw@mail.gmail.com>
 (Richard Weinberger's message of "Wed, 18 Nov 2020 22:46:14 +0100")
Message-ID: <874klikp75.fsf@collabora.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Martyn Welch <martyn@collabora.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Richard Weinberger <richard.weinberger@gmail.com> writes:

> On Wed, Nov 18, 2020 at 10:19 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> Anton Ivanov <anton.ivanov@cambridgegreys.com> writes:
>>
>> > On 25/10/2020 04:41, Gabriel Krisman Bertazi wrote:
>> >> Internally, UBD treats each physical IO segment as a separate command to
>> >> be submitted in the execution pipe.  If the pipe returns a transient
>> >> error after a few segments have already been written, UBD will tell the
>> >> block layer to requeue the request, but there is no way to reclaim the
>> >> segments already submitted.  When a new attempt to dispatch the request
>> >> is done, those segments already submitted will get duplicated, causing
>> >> the WARN_ON below in the best case, and potentially data corruption.
>> >> In my system, running a UML instance with 2GB of RAM and a 50M UBD
>> >> disk,
>>
>> >>   [...]
>> >> ---[ end trace c6e7444e55386c0f ]---
>> >> Cc: Christopher Obbard <chris.obbard@collabora.com>
>> >> Reported-by: Martyn Welch <martyn@collabora.com>
>> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>>
>> > Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Hi,
>>
>> Is this queued somewhere?  I've been watching the linux-next branch of
>
> I had only one minor comment but apparently the mail got stuck locally. :-(
> Just sent my mail again.

Thanks for the feedback.  I fixed up the array declaration and I'm just
completing it a new round of test before sending the v2.

-- 
Gabriel Krisman Bertazi

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

