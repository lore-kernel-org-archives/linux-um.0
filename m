Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcTLa-0002t8-Tv
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 13:06:07 +0000
Subject: Re: [PATCH] um: Fetch registers only for signals which need them
References: <20201110111137.16117-1-anton.ivanov@cambridgegreys.com>
 <1e0dc5977c309d777ff4155565eb4d667733256a.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <463ae63b-2095-9cfb-903a-72899a1d39b5@cambridgegreys.com>
Date: Tue, 10 Nov 2020 13:06:03 +0000
MIME-Version: 1.0
In-Reply-To: <1e0dc5977c309d777ff4155565eb4d667733256a.camel@sipsolutions.net>
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
Cc: richard@nod.at



On 10/11/2020 11:27, Johannes Berg wrote:
> On Tue, 2020-11-10 at 11:11 +0000, anton.ivanov@cambridgegreys.com
> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> UML userspace fetches siginfo and passes it to signal handlers
>> in UML. This is needed only for some of the signals, because
>> key handlers like SIGIO make no use of this variable.
> 
> It looks like even for SIGSEGV it depends on PTRACE_FULL_FAULTINFO,
> which is only set for 64-bit?
> 
> 
>> -			ptrace(PTRACE_GETSIGINFO, pid, 0, (struct siginfo *)&si);
>> +			switch (sig) {
>> +			case SIGSEGV:
>> +			case SIGTRAP:
>> +			case SIGILL:
>> +			case SIGBUS:
>> +			case SIGFPE:
>> +			case SIGWINCH:
>> +				ptrace(PTRACE_GETSIGINFO, pid, 0, (struct siginfo *)&si);
>> +				break;
>> +			}
>>   
>>   			switch (sig) {
>>   			case SIGSEGV:
> 
> So perhaps it might make sense to push it further down into that switch?
> It'd end up duplicating it to three places though.
> 
> In the SIGIO case you could write it as
> 
> case SIGILL:
> case SIGBUS:
> case SIGFPE:
> case SIGWINCH:
> 	ptrace(...);
> 	fallthrough;

gcc now complains loudly about fallthrough cases. Though I can override it, I'd rather leave the original approach where there is a list of SIGs which need the si fetched.

> case SIGIO:
> 	block_signals_trace();
> 	// etc
> 
> But I have no strong opinion either way really.
> 
> 
> I do think a comment is needed though, because we _do_ pass the pointer

I added a comment to v2 which explains what and why is being done.

> to the sigio handler ... or maybe separate that out just like
> handle_trap() etc.?
> 
> johannes
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

